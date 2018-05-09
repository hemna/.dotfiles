#!/usr/bin/env bash

function install_app() {
  # Detect the platform (similar to $OSTYPE)
  OS="`uname`"
  case $OS in
    'Linux')
      OS='Linux'
      issue=$(lsb_release -is)
      case $issue in
          'SUSE') installer='zypper in' ;;
          'openSUSE Project') installer='zypper in' ;;
          'Ubuntu') installer='apt install' ;;
          *) ;;
      esac
      cmd='sudo $installer $1'
      echo $cmd
      exec $cmd
      ;;
    'Darwin')
      OS='Mac'
      cmd="brew install $1"
      echo $cmd
      exec $cmd
      ;;
  *) ;;
  esac
}


function install_jo_src() {
  cd src
  # install jo
  # need autoconf, automake, libtool
  install_app autoconf automake libtool
  git clone https://github.com/jpmens/jo && cd jo
  autoreconf -i
  ./configure
  make check
  sudo make install
}

function install_jo() {
  # on the Mac, we can use brew
  OS="`uname`"
  case $OS in
      'Darwin') install_app jo ;;
      'Linux')  install_jo_src ;;
      *) ;;
  esac
}

# make sure we have a src dir
mkdir src

# install jo
install_jo

# make sure .vim submodules are installed
cd .vim
git submodule init
git submodule update --init --recursive

# Need to build and install YouCompleteMe
# need cmake and gcc-c++
# sudo zypper in cmake gcc-c++ python-devel
cd bundle/YouCompleteMe
./install.py

cd ../..

# use this to setup the basic shell and pull what is needed
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

chsh -s $(which zsh)

./link.sh
