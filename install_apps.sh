#!/usr/bin/env bash

source lib/core.sh

function install_app() {
  # Detect the platform (similar to $OSTYPE)
  echo $OS
  echo $DIST
  echo "Install $1"

  if [ "$OS" == "mac" ]; then
      cmd="brew install"
  fi

  if [ "$OS" == "linux" ]; then
    if [ "$DIST" == "ubuntu" ]; then
      cmd="sudo apt-get install -y"
    elif [ "$DIST" == "suse" ]; then
      cmd="sudo zypper in -y"
    fi
  fi

  cmd=`$cmd $1`
}


function install_jo_src() {
  cd src
  # install jo
  # need autoconf, automake, libtool
  install_app autoconf
  install_app automake
  install_app libtool
  git clone https://github.com/jpmens/jo && cd jo
  autoreconf -i
  ./configure
  make check
  sudo make install
}

function install_jo() {
  # on the Mac, we can use brew
  case $OS in
      'mac') install_app jo ;;
      'linux')  install_jo_src ;;
      *) ;;
  esac
}

# make sure we have a src dir
if [ ! -d src ]; then
  mkdir src
fi

# install jo
install_jo
