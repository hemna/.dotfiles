#!/bin/bash

cd ~
echo "Clone the repo"
git clone git@github.com:hemna/.dotfiles.git
cd .dotfiles
./setup.sh
