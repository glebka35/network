#!/bin/bash

server=172.72.1.0      # server IP
port=22                 # port
connect_timeout=5       # Connection timeout

iperf -seu -p 8080 &
iperf -se -p 8080 &

while true; do
    #sshpass -p "test" ssh -oStrictHostKeyChecking=no -oConnectTimeout=8 -i id_rsa test@172.72.1.0 && echo "SSH request was succeeded!"
    

    timeout $connect_timeout bash -c "</dev/tcp/$server/$port"
    if [ $? == 0 ];then
        echo "SSH Connection to $server over port $port is possible"
    else
        echo "SSH connection to $server over port $port is not possible"
    fi

    ping 172.72.1.0 -c 5
done
