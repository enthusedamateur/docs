#!/bin/bash

echo "Which pi? format rpix-xx"

read pi

echo "Location to copy from on the remote server? eg. /home/pi/dir"

read rem 

echo "Location to copy to? eg. /home/pi/dir"

read host

rsync -Pav -e "ssh -i $HOME/.ssh/id_rsa" michael@$pi.lan:$rem $host
