#!/usr/bin/env bash
DST=$HOME
ABSPATH="$(cd "${0%/*}" 2>/dev/null; echo "$PWD"/"${0##*/}")"
SRC=`dirname $ABSPATH`

function link {
 ln -s $SRC/$1 $DST/$1
}

link .vimrc
link .bashrc
link .screenrc
link .gitconfig
link .vim
