#!/bin/bash

if [ ! -d ~/.dotfiles ]; then
    git clone git@github.com:logston/dotfiles.git ~/.dotfiles
fi

cd ~/.dotfiles

brew bundle --verbose --file Brewfile

./stow.sh
