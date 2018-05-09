#!/bin/bash

cd ~
echo "Clone the repo"
git clone https://github.com/hemna/.dotfiles
cd .dotfiles
./setup.sh
