#!/usr/bin/env bash

oldpwd=$PWD

# make sure .vim submodules are installed
cd .vim
git submodule init
git submodule update --init --recursive

# Need to build and install YouCompleteMe
# need cmake and gcc-c++
# sudo zypper in cmake gcc-c++ python-devel
cd bundle/YouCompleteMe
./install.py

cd $oldpwd

# use this to setup the basic shell and pull what is needed
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

iszsh=`which zsh | wc -l`

# only set to zsh if it exists
if [ iszsh -eq 1]; then
  chsh -s $(which zsh)
fi

./link.sh
