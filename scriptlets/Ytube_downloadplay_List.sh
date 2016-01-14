#!/bin/bash
if [ ${#@} = 0 ]
then
	echo "\$1 : Link to YouTube playlist"
	echo "\$2 : Directory to download to"
	exit 1
fi
PlayList_Link=$1
download_Dir=$2
#OUT="local"
#OUT="hdmi"
#VOL="2250"
DownloadLinks(){
	for lines in $(lynx --source "$PlayList_Link" | grep -i "watch?v=" | uniq -u | grep -o "data-video-id.*" | awk '{gsub("\""," "); print "https://youtube.com/watch?v="$2}')
	do
		echo "Downloading $lines to : $download_Dir"
		echo "youtube-dl -kc -o \"$download_Dir/%(title)s-%(id)s.%(ext)s\" $lines"
		youtube-dl -kc -o "$download_Dir/%(title)s-%(id)s.%(ext)s" $lines
		clear
	done
}
DownloadLinks
