#!/bin/bash

if [ ! -d ~/.dotfiles ]; then
    git clone git@github.com:logston/dotfiles.git ~/.dotfiles
fi

if ! command -v stow &> /dev/null
then
    brew install stow
fi

cd ~/.dotfiles

stow bash
stow ctags
stow git
stow less
stow pdbpp
stow tmux
stow vim
stow zsh
