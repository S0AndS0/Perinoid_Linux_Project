#!/bin/bash

if [ ${#@} = 0 ]
then
	echo "This script requires root or sudo permissions and will monitor ports 80 and 443 by default"
	echo "\$1 : interface such as wlan0"
	echo "\$2 : number of interactions before exit such as 5"
fi

watch_interface=$1
count_int=$2

while true
do
	netstat -nat | awk '/80|443/{print $3,$4,$5,$6}' | grep -v 0.0.0.0 | sort --unique
	if [ ${#@} -gt 0 ]
	then
#		netstat -nat | awk '/80|443/{print $3,$4,$5,$6}' | grep -v 0.0.0.0 | sort --unique
		tcpdump -i $watch_interface port 80 or port 443 -e -n -c $count_int -Z www-data | sort --unique | awk '{print $15,$1,$10,$11,$12}'
	fi
	sleep 1
done
