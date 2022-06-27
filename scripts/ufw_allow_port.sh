#!/bin/bash

echo "Enter ip to allow from in the format x.x.x.x/x"

read ip

echo "Enter protocol, tcp or udp?"

read prot

echo "Enter port number"

read port


sudo ufw allow from $ip proto $prot to any port $port


