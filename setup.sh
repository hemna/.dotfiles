#!/usr/bin/env bash

# make sure .vim submodules are installed
cd .vim
git submodule init
git submodule update
cd ..

# use this to setup the basic shell and pull what is needed
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

chsh -s $(which zsh)

./link.sh
