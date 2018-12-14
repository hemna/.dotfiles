#!/bin/bash

cd ~
echo "Clone the repo"
git clone http://github.com/hemna/.dotfiles.git
cd .dotfiles
./setup.sh
