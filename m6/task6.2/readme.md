# Configuring DHCP, DNS servers and dynamic routing using OSPF protocol
1. Use already created internal-network for three VMs (VM1-VM3). VM1 has NAT and internal, VM2, VM3 – internal only interfaces.
There have already been created at task 6.1 
2. Install and configure DHCP server on VM1. (3 ways: using VBoxManage, DNSMASQ and ISC-DHSPSERVER). You should use at least 2 of them.
```
$ sudo apt install isc-dhcp-server
```
Add internal interface in /etc/default/isc-dhcp-server:
```
INTERFACESv4="enp0s8"
```
Modify /etc/dhcp/dhcpd.conf
```
subnet 192.168.255.0 netmask 255.255.255.0 {
        option routers                  192.168.255.1;
        option subnet-mask              255.255.255.0;
        option domain-search            "example.org";
        option domain-name-servers      192.168.255.1;
        range   192.168.255.10   192.168.255.100;
}
```
Restart and enabled service
```
$ sudo systemctl start isc-dhcp-server
$ sudo systemctl enable isc-dhcp-server
```
Allow traffic
```
$ sudo ufw allow 67/udp
$ sudo ufw reload
```
3. Check VM2 and VM3 for obtaining network addresses from DHCP server.
Client netplan
```
dhcp4: yes
```
Example VM2
```
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:56:d4:08 brd ff:ff:ff:ff:ff:ff
    inet 192.168.255.10/24 brd 192.168.255.255 scope global dynamic noprefixroute enp0s3
       valid_lft 364sec preferred_lft 364sec
    inet6 fe80::a00:27ff:fe56:d408/64 scope link 
       valid_lft forever preferred_lft forever
```
4. Using existed network for three VMs (from p.1) install and configure DNS server on VM1. (You can use DNSMASQ, BIND9 or something else).
```
$ sudo apt-get install bind9 bind9utils bind9-doc
```
Edit /etc/default/named for disable ipv6
```
OPTIONS="-u bind -4"
```
Edit block "options" at /etc/bind/named.conf.options
```
        recursion yes;
        allow-recursion { localnets; };
        allow-transfer { none; };
        forwarders {
                8.8.8.8;
                8.8.4.4;
        };
 ```
#### It's enough for caching DNS server
#### For local DNS zone
Edit /etc/bind/named.conf.local
```
zone "example.org" {
    type master;
    file "/etc/bind/zones/db.example.org";
    allow-transfer { none; };
};
zone "255.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.192.168.255";
    allow-transfer { none; };
};
```
Create zones files
```
$ mkdir /etc/bind/zones
$ sudo cp /etc/bind/db.local /etc/bind/zones/db.example.org
$ sudo cp /etc/bind/db.127 /etc/bind/zones/db.192.168.255
```
Edit db.example.org
```
; BIND data file for local loopback interface
$TTL    604800
@       IN      SOA     vm1.example.org. root.example.org. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
; name servers - NS records
@       IN      NS      vm1.example.org.
; name servers - A records
vm1.example.org.          IN      A       192.168.255.1
; services - A records
@                         IN      A      192.168.255.1
serv1.example.org.        IN      A      192.168.255.2
serv2.example.org.        IN      A      192.168.255.3
```
Edit db.192.168.255
```
; BIND reverse data file for local loopback interface
;
$TTL    604800
@       IN      SOA     localhost. root.localhost. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
; name servers
      IN      NS      vm1.example.org.
; PTR Records
1     IN      PTR     vm1.example.org.  
2     IN      PTR     serv1.example.org.
3     IN      PTR     serv2.example.org.
```
Check and restart
```
$ sudo named-checkconf
$ sudo systemctl start named.service
$ sudo ufw allow Bind9
```
5. Check VM2 and VM3 for gaining access to DNS server (naming services).

```
```
Example VM2
```
$ nslookup google.com 192.168.255.1
Server:		192.168.255.1
Address:	192.168.255.1#53

Non-authoritative answer:
Name:	google.com
Address: 142.250.201.206
Name:	google.com
Address: 2a00:1450:400d:80a::200e

$ nslookup serv1.example.org 192.168.255.1
Server:		192.168.255.1
Address:	192.168.255.1#53

Name:	serv1.example.org
Address: 192.168.255.2
```
