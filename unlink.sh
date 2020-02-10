#!/usr/bin/env bash
DST=$HOME
ABSPATH="$(cd "${0%/*}" 2>/dev/null; echo "$PWD"/"${0##*/}")"
SRC=`dirname $ABSPATH`

function link {
 if [ -e "$DST/$1" ]
 then
     rm $DST/$1
 fi
}

link .aliases
link .bashrc
link .zshrc

link .gitconfig
link .screenrc
#link .vim
#link .vimrc
link .vimrc.local
link .tmux.conf
link .bin

# remove manual add
rm ~/.oh-my-zsh/themes/walt-sap.zsh-theme
