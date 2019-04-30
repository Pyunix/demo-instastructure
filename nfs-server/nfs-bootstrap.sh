#!/bin/bash

apt-get update

apt install nfs-kernel-server -y

for i in {1..3}; do
    mkdir -p /mnt/pv$i
    chown nobody:nogroup /mnt/pv$i
    chmod 777 /mnt/pv$i
    echo "/mnt/pv${i}    192.168.50.0/24(rw,sync,no_subtree_check)" >> /etc/exports;
done

systemctl restart nfs-kernel-server

systemctl status nfs-kernel-server

ufw allow from 192.168.50.0/24 to any port nfs

ufw status
