#!/bin/bash

for file in .*;
do
	if [ ! -f "$file" ]; then
		continue
	fi

	if [ "$file" == '.' ] || [ "$file" == '..' ]; then 
		continue
	fi

	rm ~/$file
	ln -s $(pwd)/$file ~/$file

	echo "Placed $(pwd)/$file -> ~/$file"
done
