#!/usr/bin/env bash

source lib/core.sh

function install_app() {
  # Detect the platform (similar to $OSTYPE)
  #echo $OS
  #echo $DIST
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

  echo "Running '$cmd $1'"
  cmd=`$cmd $1`
}

function test_or_install_app() {

  is_installed=`which $1 | grep "not found" | wc -l`
  if [ $is_installed -eq 1 ]; then
    install_app $1
  else
    echo "$1 already installed"
    fi
}


function install_jo_src() {
  cd src
  # install jo
  # need autoconf, automake, libtool
  test_or_install_app autoconf
  test_or_install_app automake
  test_or_install_app libtool
  if [ -d jo ]; then
    rm -rf jo
  fi
  echo "Building Jo from src"
  echo "Find info about jo here: https://github.com/jpmens/jo"
  git clone https://github.com/jpmens/jo && cd jo
  autoreconf -i
  ./configure
  make check
  sudo make install
  cd ..
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
