#!/bin/bash

curl -sSL https://get.docker.com | sh

sudo apt-get install libffi-dev libssl-dev python3-dev python3 python3-pip -y

sudo pip3 install docker-compose

sudo systemctl enable docker
