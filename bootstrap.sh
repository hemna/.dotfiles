#!/bin/bash

cd ~
echo "Clone the repo"
git clone http://github.com/hemna/mydamnshell.git
cd mydamnshell
wget -O group_vars/all https://raw.githubusercontent.com/hemna/.dotfiles/ansible/group_vars/all
./run.sh
