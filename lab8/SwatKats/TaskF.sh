#!/bin/bash
	declare ma=()
    for i in `ls`; do
    	if [ "$i" != "TaskF.sh" ]; then
        	ma[$i]=$(/usr/bin/time -f "%E" ./$i 2>&1 1>/dev/null )
    	fi
    done

   	sortedArray=$(for i in $(ls)
	do
		if [ "$i" != "TaskF.sh" ]; then
    		echo "$i ${ma[$i]}"
    	fi
	done | sort -k 2,2)
	
	sortedArray2=$(for i in "${sortedArray[@]}"
	do
		echo "$i" | cut -f 1 -d " "
	
	done)
	x=$(echo $sortedArray2 | tr " " "\n")
	for file in $x;
	do
		./$file
	done