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
#link .vim
#link .vimrc
link .tmux.conf
link .bin
link .vimrc.local
link .iterm2.zsh

link .xonshrc


# manually link the sap theme
ln -s $SRC/walt-sap.zsh-theme ~/.oh-my-zsh/themes/walt-sap.zsh-theme
ln -s ~$SRC/starship.toml ~/.config
