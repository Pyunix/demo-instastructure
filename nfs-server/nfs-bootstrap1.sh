#!/bin/bash

apt-get update

apt-get install nfs-common -y 

mkdir -p /mnt/sharedfolder_client

mount 192.168.50.15:/mnt/sharedfolder /mnt/sharedfolder_client
