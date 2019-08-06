#!/usr/bin/env bash
DST=$HOME
ABSPATH="$(cd "${0%/*}" 2>/dev/null; echo "$PWD"/"${0##*/}")"
SRC=`dirname $ABSPATH`

function link {
 if [ -e "$DST/$1" ]
 then
     rm $DST/$1
 fi
 ln -s $SRC/$1 $DST/$1
}

link .aliases
link .bashrc
link .zshrc

link .gitconfig
link .screenrc
link .vim
link .vimrc
link .tmux.conf
link .bin

ln -s $SRC/fish ~/.config
