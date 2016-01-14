#!/bin/bash
if [ ${#@} = 0 ]
then
	echo "No arguemtns passed. Exiting"
	echo "Usage: '\$1' should be a file path to a list of user@host file"
	echo "Usage: '\$2' should be a file or directory to share to the above listed file"
	echo "Example : rsync_multi.sh '/media/32gb/rpi/dumps/sshAddresses.txt' '/media/32gb/rpi/music/Cake/Comfort_Eagle'"
	echo "The file for addresses should be formatted : User@hostIP : one per line"
	echo "If using non standard ports use -P in '\$Command' variable"
	echo "If using non-standard key location use -i option within the same variable too."
	exit 1
fi
UsersFile="$1"
FILE="$2"
KEY="/home/pi/.ssh/id_littlejohn_rsa"

# Parce file given by $1 for usernames and port numbers
while read line
do
	ADDR=$line
	UserName=$(echo "$ADDR" | sed 's/\@/ /' | awk '{print $1}')
	IPaddr=$(echo "$ADDR" | sed 's/\@/ /' | awk '{print $2}')
	Port=$(echo "$ADDR" | sed 's/\@/ /' | awk '{print $3}')
	echo "User-$UserName via port-$Port at-$IPaddr : Will have the following preformed : "
	echo "rsync --progress -vazh -e \"ssh -i ${KEY} -p ${Port}\" ${FILE} ${UserName}@${IPaddr}:/home/${UserName}/sync/"
		rsync --progress -vazh -e "ssh -i ${KEY} -p ${Port}" ${FILE} ${UserName}@${IPaddr}:/home/${UserName}/sync/
done < $UsersFile

