#!/usr/bin/env bash
set -x

cd ~/.dotfiles

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
if [ ! -d ~/.oh-my-zsh ]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
else
    cd ~/.oh-my-zsh
    git submodule update --init --recursive
fi

# try and setup fish
cd ~/.dotfiles
source setup_fish.sh

iszsh=`command -v zsh | wc -l`

# only set to zsh if it exists
#if [ $iszsh -eq 1 ]; then
#  chsh -s $(which zsh)
#fi

cd ~/.dotfiles
./link.sh

# now install the iterm2 integration
curl -L https://iterm2.com/misc/install_shell_integration.sh | bash
