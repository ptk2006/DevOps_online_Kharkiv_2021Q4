#!/bin/bash
function help {
    echo "
    Usage:
    ./netscan.sh [options]
    Options:
    --all                           scan alive hosts
    --target IP(DNS name)           scan port on target host"
}
function alivehost {
    network=`/sbin/ip -o -f inet addr show | awk '/scope global/ {print $4}' | tail -1`
    echo "Alive hosts in local network:"
    fping --alive --addr --rdns --quiet --retry=1 --generate $network
}
function targetports {
    nmap -sT -F -P0 $host
}
case $1 in 
    --all)
        alivehost
        ;;
    --target)
        host=$2
        targetports
        ;;
    *)
        help
        ;;
esac