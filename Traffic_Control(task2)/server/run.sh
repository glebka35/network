#!/bin/bash

tc qdisc del dev eth0 root
tc qdisc add dev eth0 root handle 1:0 htb default 14

# Задаем пропускную способность
tc class add dev eth0 parent 1:0 classid 1:1 htb rate 100mbit 

# Дропаем ICMP
tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip protocol 1 0xff action drop

# Дропаем ssh на 3 клиенте
tc filter add dev eth0 protocol ip parent 1:0 prio 0 u32 match ip src 172.72.3.0/24 match ip protocol 6 0xff match ip sport 22 0xffff action drop

tc class add dev eth0 parent 1:0 classid 1:10 htb rate 100mbit prio 1
tc class add dev eth0 parent 1:10 classid 1:11 htb rate 5mbit ceil 40mbit prio 1
tc class add dev eth0 parent 1:10 classid 1:12 htb rate 5mbit ceil 20mbit prio 1
tc class add dev eth0 parent 1:10 classid 1:121 htb rate 5mbit ceil 20mbit prio 2
tc class add dev eth0 parent 1:10 classid 1:13 htb rate 5mbit ceil 20mbit prio 1
tc class add dev eth0 parent 1:10 classid 1:14 htb rate 5mbit ceil 20mbit prio 1
tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 172.72.1.0/24 flowid 1:11
tc filter add dev eth0 protocol ip parent 1:0 prio 2 u32 match ip dst 172.72.2.0/24 match ip protocol 17 0xff flowid 1:121
tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 172.72.2.0/24 flowid 1:12
tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 172.72.3.0/24 flowid 1:13
tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 172.72.4.0/24 flowid 1:14

service ssh start
service ssh status

while true; do
    sleep 7
    #iperf -c 172.72.1.1 -p 8080 -e -i 1 -t 1 &
    #iperf -c 172.72.1.1 -u -p 8080 -e -i 1 -t 1 &
    #iperf -c 172.72.2.2 -p 8080 -e -i 1 -t 1 &
    #iperf -c 172.72.2.2 -u -p 8080 -e -i 1 -t 1 &
    #iperf -c 172.72.3.3 -p 8080 -e -i 1 -t 1 &
    #iperf -c 172.72.3.3 -u -p 8080 -e -i 1 -t 1 &
    #iperf -c 172.72.4.4 -p 8080 -e -i 1 -t 1 &
    #iperf -c 172.72.4.4 -u -p 8080 -e -i 1 -t 1 &
done
