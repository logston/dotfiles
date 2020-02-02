#!/bin/bash

for file in .*;
do
	if [ ! -f "$file" ]; then
		continue
	fi

	if [ "$file" == '.' ] || [ "$file" == '..' ]; then 
		continue
	fi

	ln -s $file ~/$file

	echo "Placed $file -> ~/$file"
done
