#!/bin/bash
cat dictionary.txt | while read a; do
	OUT=`yes | unzip -p -P "$a" legendaryPokemon.zip`
	if [[ "$OUT" != "" ]]; then
		yes | unzip -p -P "$a" legendaryPokemon.zip > ./legendaryPokemon/legendaryPokémon
		echo $a
	fi
done