#!/bin/bash

#script to push images into folders

start=14
count=0
files=$(ls -a)
mkdir -p  "land$start"
for file in  *.jpg *.jpeg ;do  #add file extension wildcards for the ones you want to move
	#skip if no matching file si present
	[ -e "$file" ] || continue

	##every 100 files
	if (( count > 0 && count % 369 == 0 ));then
		start=$((start+1))
		mkdir -p "land$start"
	fi

	mv $file "land$start/"
echo -e "$count $file moved to land$start"
	count=$((count+1))
done


