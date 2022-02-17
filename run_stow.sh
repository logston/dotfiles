#!/bin/bash

if ! command -v stow &> /dev/null
then
    brew install stow
fi

stow zsh
stow tmux
stow git
stow git-commands
stow neovim
stow pdbpp
