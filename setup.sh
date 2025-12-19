#!/usr/bin/env bash
set -x

if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

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

# install zinit
if [ ! -d ~/.local/share/zinit ]; then
  echo "Installing zinit"
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

# use this to setup the basic shell and pull what is needed
#if [ ! -d ~/.oh-my-zsh ]; then
#  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
#else
#    cd ~/.oh-my-zsh
#    git submodule update --init --recursive
#fi

# install starship prompt 
tmp=`pwd`
cd /tmp && \
    wget https://starship.rs/install.sh && \
    chmod +x install.sh && \
    ./install.sh -y && \
    rm install.sh && \
    cd $tmp

# try and setup fish
cd ~/.dotfiles
source setup_zsh.sh
source setup_fish.sh
source setup_xonsh.sh

#iszsh=`command -v zsh | wc -l`

# only set to zsh if it exists
#if [ $iszsh -eq 1 ]; then
#  chsh -s $(which zsh)
#fi

# Install the vim setup
curl -L https://raw.githubusercontent.com/hemna/spf13-vim/walt/bootstrap.sh | bash

cd ~/.dotfiles
./link.sh

# now install the iterm2 integration
curl -L https://iterm2.com/misc/install_shell_integration.sh | bash

# Install notes
curl -L https://raw.githubusercontent.com/pimterry/notes/latest-release/install.sh | bash
