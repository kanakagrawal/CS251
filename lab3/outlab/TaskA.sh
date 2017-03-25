#A
find -type f -size +50k -size -100k -iname "t*" -perm u=r -not -perm o=r,g=r -not -writable -not -executable 

#B
sed -n '/^\([gG][rR][aA][sS][sS]\|[Ww][Aa][Tt][Ee][Rr]\) \w*\b$/p' Shanghai | grep -v "[mMbB]" | grep "\w*\b \w\?\w\?\w\?\w\?\w\w\w\w\w\w"

#C
find . -mindepth 1 -maxdepth 1 -type d -exec rm -f -r '{}' \;
find . -type f -name 'A*' -exec rm -f '{}' \;
find . -type f -regextype posix-extended -regex './([1-9]|1[0-9]|20)' -exec rm -f '{}' \;
find . -type f -name '*.jpg' -exec rm -f '{}' \;
cat $(ls) > ultraball.html
#why ultraball.txt doesn't show the name of pokemon? answer needed.

#D
#Squirtle
#"alpha omega"
curl -d 'username=alpha&password=omega' https://www.cse.iitb.ac.in/~sharat/current/cs251/Assign/Lab03/support/verify.php

#E

#F
#Congrats you have captured Rotom
#text/html;test/x-c;image/jpeg;application/gzip
#taskF.sh

#G
ls -l -t -r | awk '{print $5}'
#ls -l -t -r | awk '{printf "%c",$5}'
#It splashes around. Guess What? Magikarp




#H
#right the below command in terminal
vim corruptedPokémon
#the following 5 commands are to be written in vim editor
	:%s/\(flying\|fighting\)/255 0 0/g
	:%s/\(Atk\|Sp\.A\|Def\|Sp\.D\):1[0-9][0-9]/255 8 153/g
	:%s/HP-\(\([0-9]\|[1-9][0-9]\|[1-9][0-9][0-9]\)\)\/\([0-9]\|[1-9][0-9]\|[1-9][0-9][0-9]\)/\1/g
	:w
	:q
# Now open the corruptedPokémon image to get Hawlucha Pokemon

#I
# Pokemon : Mewtow
# correct password ShadowBall