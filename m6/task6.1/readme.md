# Networking with Linux
1. Create virtual machines connection according to figure 1:
![image](https://user-images.githubusercontent.com/88320899/146198837-4da451a2-ea12-427f-8af6-346677117f2d.png)
2. VM2 has one interface (internal), VM1 has 2 interfaces (NAT and internal). Configure all network interfaces in order to make VM2 has an access to the Internet (iptables, forward, masquerade).
#### vm1 - Ubuntu
```
#/etc/netplan/01-network-manager-all.yaml
network:
  version: 2
  renderer: NetworkManager
  ethernets:
      enp0s3:
         dhcp4: yes
      enp0s8:
         dhcp4: no
         addresses: [192.168.255.1/24]
```
```
#/etc/sysctl.conf
net.ipv4.ip_forward=1
```
```
#/etc/default/ufw
DEFAULT_FORWARD_POLICY="ACCEPT"
```
```
#/etc/ufw/before.rules
#nat Table rules
*nat
:POSTROUTING ACCEPT [0:0]
#Forwardtraffic from enp0s8 through enp0s3.
-A POSTROUTING -s 192.168.255.0/24 -o enp0s3 -j MASQUERADE
#don't delete the 'COMMIT' line or these nat table rules won't be processed
COMMIT
```
#### vm2 - Ubuntu
```
#/etc/netplan/01-network-manager-all.yaml
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    enp0s3:
      dhcp4: no
      addresses: [192.168.255.2/24]
      gateway4: 192.168.255.1
      nameservers:
        addresses: [8.8.4.4,8.8.8.8]
```
3. Check the route from VM2 to Host.

![image](https://user-images.githubusercontent.com/88320899/146204221-1b42ad5d-5efa-4140-89ce-2de27b52393c.png)

4. Check the access to the Internet, (just ping, for example, 8.8.8.8).
5. Determine, which resource has an IP address 8.8.8.8.
### nslookup 8.8.8.8
```
8.8.8.8.in-addr.arpa	name = dns.google.
```
6. Determine, which IP address belongs to resource epam.com.
### dig epam.com
```
; <<>> DiG 9.16.15-Ubuntu <<>> epam.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 15806
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1
;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;epam.com.			IN	A
;; ANSWER SECTION:
epam.com.		2782	IN	A	3.214.134.159
;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: ср гру 15 16:31:55 EET 2021
;; MSG SIZE  rcvd: 53
```
7. Determine the default gateway for your HOST and display routing table.
### ip r
8. Trace the route to google.com.
### mtr google.com
