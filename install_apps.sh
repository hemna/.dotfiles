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

function is_installed() {
    local is_installed=`command -v $1 | wc -l`
    echo "$is_installed"
}

function test_or_install_app() {
  is_it=$(is_installed $1)
  if [ $is_it -eq 0 ]; then
    install_app $1
  else
    echo "$1 already installed"
    fi
}


function install_jo_src() {
  is_it=$(is_installed jo)
  if [ $is_it -eq 1 ]; then
      echo "jo already installed"
      return
  else
      echo "Building Jo from src"
  fi

  # install jo
  # need autoconf, automake, libtool
  test_or_install_app autoconf
  test_or_install_app automake
  test_or_install_app libtool
  if [ -d jo ]; then
    rm -rf jo
  fi
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

function install_xclip() {
  # mac already has pbcopy
  case $OS in
      'linux') test_or_install_app xclip ;;
      *) ;;
  esac
}

function install_coreutils() {
  # on the Mac, we can use brew
  case $OS in
      'mac') install_app coreutils ;;
      *) ;;
  esac
}

# make sure we have a src dir
if [ ! -d src ]; then
  mkdir src
fi

# install zsh
test_or_install_app zsh

# install coreutils on mac only
install_coreutils

# install xclip on linux only
install_xclip

# install jo
install_jo
