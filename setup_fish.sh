#!/bin/bash

ABSPATH="$(cd "${0%/*}" 2>/dev/null; echo "$PWD"/"${0##*/}")"
SRC=`dirname $ABSPATH`

if [ ! -d ~/.config/fish ]; then
    ln -s $SRC/fish ~/.config
fi

if [ ! -d ~/.oh-my-fish ]; then
    git clone https://github.com/oh-my-fish/oh-my-fish
    cd oh-my-fish
    bin/install --path=~/.oh-my-fish
else
    cd ~/.oh-my-fish
    git pull origin
    git submodule update --init --recursive
fi

# fish should be here now
cd ~/.dotfiles
~/.dotfiles/setup_fish_post.fish
