#!/bin/bash

find ./Earth/Europe/Ukraine/Kiev -type f -exec file -i '{}' \; | sort -k 2 | grep text/html | cut -f 1 -d ":" | while read a; do
		mv  "$a" "$a.html"
	done
find ./Earth/Europe/Ukraine/Kiev -type f -exec file -i '{}' \; | sort -k 2 | grep image/jpeg | cut -f 1 -d ":" | while read a; do
		mv  "$a" "$a.jpeg"
	done
find ./Earth/Europe/Ukraine/Kiev -type f -exec file -i '{}' \; | sort -k 2 | grep text/x-c | cut -f 1 -d ":" | while read a; do
		mv  "$a" "$a.c"
	done
find ./Earth/Europe/Ukraine/Kiev -type f -exec file -i '{}' \; | sort -k 2 | grep application/g | cut -f 1 -d ":" | while read a; do
		mv  "$a" "$a.tar.gz"
	done
