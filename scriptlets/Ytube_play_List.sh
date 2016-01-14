#!/bin/bash
if [ ${#@} = 0 ]
then
	exit 1
fi
PlayList_Link=$1
OUT="local"
VOL="2250"
PlayLinks(){
	for lines in $(lynx --source "$PlayList_Link" | grep -i "watch?v=" | uniq -u | grep -o "data-video-id.*" | awk '{gsub("\""," "); print "https://youtube.com/watch?v="$2}')
	do
		echo "Playing $lines"
		echo "omxplayer -o $OUT --vol -$VOL \"\$(youtube-dl -g $lines)\""
		omxplayer -o $OUT --vol -$VOL "$(youtube-dl -g $lines)"
		clear
	done
}
PlayLinks
