#!/bin/bash

if ! command -v stow &> /dev/null
then
    brew install stow
fi

stow git
stow pdbpp
stow tmux
stow vim
stow zsh
