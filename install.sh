#!/bin/bash

if [ ! -d ~/.dotfiles ]; then
    git clone git@github.com:logston/dotfiles.git ~/.dotfiles
fi

cd ~/.dotfiles

for file in .*;
do
	if [ ! -f "$file" ]; then
		continue
	fi

	if [ "$file" == '.ctags-index' ]; then
		continue
	fi

	if [ "$file" == '.gitignore' ]; then
		continue
	fi

	if [ "$file" == '.' ] || [ "$file" == '..' ]; then 
		continue
	fi

	rm ~/$file
	ln -s $(pwd)/$file ~/$file

	echo "Placed $(pwd)/$file -> ~/$file"
done

cd -
