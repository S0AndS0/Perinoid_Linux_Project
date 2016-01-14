#!/bin/bash
if [ ${#@} = 0 ]
then
	echo "\$1 : should be text you wish translated to speach via google"
	exit 1
fi

mplayer -ao alsa -noconsolecontrols "http://translate.google.com/translate_tts?tl=en&q=$*" > /dev/null 2>&1
