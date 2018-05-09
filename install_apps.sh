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
