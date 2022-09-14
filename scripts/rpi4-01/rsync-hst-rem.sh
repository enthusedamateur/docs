#!/bin/bash


echo "dir/file to copy?"

read host

echo "Which pi? format rpix-xx"

read pi

echo "Location to copy to?"

read rem


rsync -Pav $host -e "ssh -i $HOME/.ssh/id_rsa" michael@$pi.lan:$rem
