#!/bin/bash
if [ ${#@} = 0 ]
then
	echo "No arguemtns passed. Exiting"
	echo "Usage: '\$1' should be a file path to a list of user@host file"
	echo "Usage: '\$2' should be a public key file to share to the above listed file"
	echo "If using non-standard ports use -p within ssh portion of /$'COMMAND' variable"
	echo "If using non-standard key location use -i within the above variable too."
	exit 1
fi
UsersFile="$1"
PubKey="$2"
#KEY="~/.ssh/id_littlejohn_rsa.pub"
# Parce a file for usernames
for ADDR in $(cat $UsersFile)
do
	Command="cat $PubKey | ssh -p 2222 $ADDR 'mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys'"
	echo $Command
done
