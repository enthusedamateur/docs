#!/bin/bash

apt install git -y

git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global pull.rebase true 
git config --global pull.ff only
