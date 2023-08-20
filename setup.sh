#!/bin/bash

mkdir -p ~/.zsh.d

if [ ! -d ~/.dotfiles ]; then
    git clone git@github.com:logston/dotfiles.git ~/.dotfiles
fi

cd ~/.dotfiles

if [ ! -f ~/.dotfiles/tmux/.tmux.local.conf ]; then
	echo "new-session -s Default" > ~/.dotfiles/tmux/.tmux.local.conf
fi

brew install stow

./stow.sh

brew bundle --verbose --file Brewfile
