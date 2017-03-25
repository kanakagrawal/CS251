#!/bin/bash

function taunt {
	choice=$[ $RANDOM % 11 ]
	case $choice in 
		0) echo "Ahh....I'm going to die...Yeah, Just kidding...Try Again";;
		1) echo "Is that all you got??";;
		2) echo "I'm not Krillin...I won't die so easily";;
		3) echo "Hahaha...I'm stronger then Batman..Try again";;
		4) echo "At this rate, you'll be stuck here for quite some time";;
		5) echo "What was that? I can't hear you over the sound of how invincilbe I am.";;
		6) echo "Looks like you'll be missing dinner today";;
		7) echo "Don't you know any other moves?";;
		8) echo "Pain is temporary, but CELL is forever!";;
		9) echo "Wake me up when you've become stronger";;
		10) echo "HINT: SIGKILL"
	esac
}

for x in {1..64}; do
	trap "taunt" $x
done

while true;do true;done