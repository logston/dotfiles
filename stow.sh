#!/bin/bash

mkdir -p ~/.config

stow zsh
stow tmux
stow git
stow git-commands
stow neovim --target ../.config/
stow nvm
stow pdbpp
