#!/bin/bash
YT_LINK="$1"
echo "Playing : $YT_LINK"
omxplayer -o local --vol -2000 "$(youtube-dl -g $YT_LINK)"
