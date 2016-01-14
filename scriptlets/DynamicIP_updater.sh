#!/bin/bash
# Modify variables that contain <> and scroll to bottom of this script for usage instructions.
## Varuables
 : ${HOME?} ; ${USER?}
logDir="log"
savePath=$HOME/$logDir
extURL="<yourwebsiteURL>"
netInterface="wlan0"
dnsServerURL="http://<yourSubdomain>.duckdns.org"
DOMAIN="<yourSubdomain>"
TOKEN="<yourToken>"
updateDNSserverURL="https://www.duckdns.org/update?domains=$DOMAIN&token=$TOKEN&ip="
emailAddress="<username>@<emailaddress>"

echo "$HOME and $USER set. \n Save path : $savePath \n Logs will be saved there if enabled."
## Functions
## this function restarts network interface and updates dns server if ping to your servers web page fails. Does nothing if ping suckseeds.
UpdateDNSchecker (){
	if [ ${extURL} != 0 ]
	then
		date | tee -a /$savePathg/ipdown.log
		echo "Restarted network services because - $extURL - not reachable." | tee -a $savePath/ipdown.log
		ifdown --force $netInterface
		ifup $netInterface
		date | tee -a /$savePath/ipdown.log
		echo "Sending update to - $dnsServerURL - incase public IP changed" | tee -a $savePath/ipdown.log
		echo url=${updateDNSserverURL} | curl -k -o $savePath/duck.log -K -
		echo "Your DNS server returned..." | tee -a $savePath/ipdown.log
		cat $savePath/duck.log | tee -a $savePath/ipdown.log
		RestartServices
		roundOutlogs
		EmailResults
	fi
}
## this function is called within the above to restart ssh and other servers if ping failed 
RestartServices (){
	service ssh restart | tee -a $savePath/ipdown.log
	service xrdp restart | tee -a $savePath/ipdown.log
}
roundOutlogs (){
	echo "The results of tracerout on $extURL are;" | tee -a $savePath/ipdown.log
	traceroute $extURL | tee -a $savePath/ipdown.log
	echo "The results of netstat -rn are;" | tee -a $savePath/ipdown.log
	netstat -rn | tee -a $savePath/ipdown.log
	echo "The results of netstat -nat are;" | tee -a $savePath/ipdown.log
	netstat -nat | tee -a $savePath/ipdown.log
	date | tee -a $savePath/ipdown.log
	echo "###	 End of above log  	###" | tee -a $savePath/ipdown.log
}
## this function is called within the UpdateDNSchecker function 
EmailResults (){
	mail -a $savePath/ipdown.log -s "Updated-IP-from-$extURL" $emailAddress < /dev/null
}
## end of functions now calling main function that will start this script

UpdateDNSchecker

### End of script ###
## Usage instructions
## 	# Copy this script to your /usr/local/sbin directory
##	cp /wherever/you/downloaded/DNSupdater /usr/local/sbin/DNSupdater
##	# Provide exicutable permissions to this script
##	chmod +x /usr/local/sbin/DNSupdater
##	# Edit your /etc/conetab file and add the following line to run this script every 5 minuets
##	*/5 * 	* * * 	root 	/usr/local/sbin/DNSupdater.sh > /dev/null
