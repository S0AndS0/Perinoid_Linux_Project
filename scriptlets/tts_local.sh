#!/bin/bash
if [ ${#@} = 0 ]
then
	echo "\$1 : should be text you wish translated to speach via google"
	exit 1
fi
VOL="150"
espeak -v en -s 120 -a $VOL -p 5 "$*"
