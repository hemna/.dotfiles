#!/usr/bin/env bash

cd ~/.dotfiles
./install_apps.sh

# make sure .vim submodules are installed
cd ~/.dotfiles/.vim
git submodule init
git submodule update --init --recursive

# TODO: Add YouCompleteMe back in when
# the distros get a newer version of vim
# https://github.com/Valloric/YouCompleteMe
#
# Need to build and install YouCompleteMe
# need cmake and gcc-c++
# sudo zypper in cmake gcc-c++ python-devel
#cd bundle/YouCompleteMe
#./install.py

#cd $oldpwd

# use this to setup the basic shell and pull what is needed
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

iszsh=`command -v zsh | wc -l`

# only set to zsh if it exists
if [ $iszsh -eq 1 ]; then
  chsh -s $(which zsh)
fi

cd ~/.dotfiles
./link.sh
