#!/bin/bash

iperf -seu -p 8080 &
iperf -se -p 8080 &

while true; do
    sshpass -p "test" ssh -oStrictHostKeyChecking=no -oConnectTimeout=8 \
    -i id_rsa test@172.72.1.0 echo "SSH request was succeeded!"
    ping 172.72.1.0 -c 5
done
