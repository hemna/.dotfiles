#!/bin/bash

if [ ! -d ~/.oh-my-fish ]; then
    git clone https://github.com/oh-my-fish/oh-my-fish
    cd oh-my-fish
    bin/install --path=~/.oh-my-fish
else
    cd ~/.oh-my-fish
    git pull origin
    git submodule update --init --recursive
fi
