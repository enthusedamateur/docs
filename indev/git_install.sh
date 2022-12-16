#!/bin/bash

apt install git -y

git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global pull.rebase true 
git config --global pull.ff only
git config --global user.name "username here"
git config --global user.email "email@example.com"
git config --global color.ui true

# Paste your ssh public key into your github account settings.

# Then run the below command
# ssh -T git@github.com

# If it says something like the following, it worked:

# "Hi username! You've successfully authenticated, but Github does
# not provide shell access."
