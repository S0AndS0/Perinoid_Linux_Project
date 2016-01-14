#!/bin/bash
if [ ${#@} = 0 ]
then
	echo "Oh no, this script was run missing something..."
	echo "Useage:"
	echo "\$1 : website directory path"
	echo "	/var/www/pub/domain"
	echo "\$2 : website domain name"
	echo "	s0ands0.tk"
	echo "Exiting now..."
	exit 1
fi

webRoot_dir="$1"
webSite_name="$2"

apache2_enableSites="/etc/apache2/sites-enabled"
ssl_extPort="443"
apache2_webUser="www-data"

doStuff(){
	mkdir -p /etc/ssl/localcerts
	openssl req -new -x509 -days 365 -nodes -out /etc/ssl/localcerts/"$webSite_name".pem -keyout /etc/ssl/localcerts/"$webSite_name".key
	openssl req -new -key /etc/ssl/localcerts/"$webSite_name".key -out /etc/ssl/localcerts/"$webSite_name".csr
	chmod 600 /etc/ssl/localcerts/"$webSite_name"*
	a2enmod ssl
	writeFiles
	chown -R $apache2_webUser:$apache2_webUser $apache2_enableSites/$webSite_name
	echo "Restarting apache2 to reload new configs..."
	service apache2 restart
	echo "Provided the above did not error out you may now make a secured connection to https://$webSite_name"
}
writeFiles(){
	echo "Writing testable configuration file to : $apache2_enableSites/$webSite_name"
	echo "NameVirtualHost \*:$ssl_extPort" | tee -a $apache2_enableSites/$webSite_name
	echo "<VirtualHost \*:$ssl_extPort>" | tee -a $apache2_enableSites/$webSite_name
	echo "SSLEngine On" | tee -a $apache2_enableSites/$webSite_name
	echo "SSLCertificateFile /etc/ssl/localcerts/$webSite_name.pem" | tee -a $apache2_enableSites/$webSite_name
	echo "SSLCertificateKeyFile /etc/ssl/localcerts/$webSite_name.key" | tee -a $apache2_enableSites/$webSite_name
	echo "DocumentRoot $webRoot_dir" | tee -a $apache2_enableSites/$webSite_name
	echo "ServerName www.$webSite_name" | tee -a $apache2_enableSites/$webSite_name
	echo "</VirtualHost>" | tee -a $apache2_enableSites/$webSite_name
	echo "Use text editer such as nano to make further modifications"
	echo "Provided that the reboot of apache2 doesn't fail you can combine this config file with the default or custom config file wih the following"
	echo "	cat $apache2_enableSites/$webSite_name | $apache2_enableSites/000-default"
}


#doStuff

echo "End of script."
echo "The following will revert settings by removing new configuration file"
echo "	rm $apache2_enableSites/$webSite_name"
