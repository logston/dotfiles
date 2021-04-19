#!/bin/bash

if ! command -v stow &> /dev/null
then
    brew install stow
fi

stow bash
stow ctags
stow git
stow less
stow pdbpp
stow tmux
stow vim
stow zsh
