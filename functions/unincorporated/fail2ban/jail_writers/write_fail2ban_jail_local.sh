Write_fail2ban_jail_local(){
	Arg_checker "${@---help='Write_fail2ban_jail_local' --exit='# Write_fail2ban_jail_local # failed to be read arguments.'}" -ep='Write_fail2ban_jail_local'
	_local_jail="${_fail2ban_dir:-/etc}/fail2ban/jail.local"
	Overwrite_config_checker "${_local_jail}"
	echo '# Fail2Ban configuration file.' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# This file was composed for Debian systems from the original one' | sudo tee -a ${_local_jail}
	echo '#  provided now under /usr/share/doc/fail2ban/examples/jail.conf' | sudo tee -a ${_local_jail}
	echo '#  for additional examples.' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# To avoid merges during upgrades DO NOT MODIFY THIS FILE' | sudo tee -a ${_local_jail}
	echo '# and rather provide your changes in /etc/fail2ban/jail.local' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# Author: Yaroslav O. Halchenko <debian@onerussian.com>' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# $Revision$' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# The DEFAULT allows a global definition of the options. They can be overridden' | sudo tee -a ${_local_jail}
	echo '# in each jail afterwards.' | sudo tee -a ${_local_jail}
	echo '[DEFAULT]' | sudo tee -a ${_local_jail}
	echo '# "ignoreip" can be an IP address, a CIDR mask or a DNS host' | sudo tee -a ${_local_jail}
	echo '## Seperate addresses with a space and try to be spiciffic to avoid ignoring real threats.' | sudo tee -a ${_local_jail}
	echo 'ignoreip = 127.0.0.1/8 192.168.1.1/24' | sudo tee -a ${_local_jail}
	echo '## Definitions for find and ban times mesured in seconds and are only applied to filters that do not include these lines' | sudo tee -a ${_local_jail}
	echo 'findtime = 31536000' | sudo tee -a ${_local_jail}
	echo 'bantime  = 31536000' | sudo tee -a ${_local_jail}
	echo 'maxretry = 3' | sudo tee -a ${_local_jail}
	echo '## Above three lines are aggressive defaults that will be latter modifide on a filter by filter bases' | sudo tee -a ${_local_jail}
	echo '## 	findtime defines how far into the past to look for suspisious network behavior in defined logs' | sudo tee -a ${_local_jail}
	echo '## 	bantime defines how long an address will be banned for. Both findtime and bantime mesure time in seconds.' | sudo tee -a ${_local_jail}
	echo '##		This means that by default fail2ban will look upto 1 year into the past and keep offenders banned for 1 year.' | sudo tee -a ${_local_jail}
	echo '## 	maxretry defines how many times a filter can be matched befor an action is taken, ei 3 bad connection attempts from the..' | sudo tee -a ${_local_jail}
	echo '##		..same IP address will have that address banned for 1 year.' | sudo tee -a ${_local_jail}
	echo '# "backend" specifies the backend used to get files modification. Available' | sudo tee -a ${_local_jail}
	echo '# options are "gamin", "polling" and "auto".' | sudo tee -a ${_local_jail}
	echo '# yoh: For some reason Debian shipped python-gamin didn't work as expected' | sudo tee -a ${_local_jail}
	echo '#      This issue left ToDo, so polling is default backend for now' | sudo tee -a ${_local_jail}
	echo 'backend = auto' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# Destination email address used solely for the interpolations in' | sudo tee -a ${_local_jail}
	echo '# jail.{conf,local} configuration files.' | sudo tee -a ${_local_jail}
	echo 'destemail = root@localhost' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# ACTIONS' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# Default banning action (e.g. iptables, iptables-new,' | sudo tee -a ${_local_jail}
	echo '# iptables-multiport, shorewall, etc) It is used to define' | sudo tee -a ${_local_jail}
	echo '# action_* variables. Can be overridden globally or per' | sudo tee -a ${_local_jail}
	echo '# section within jail.local file' | sudo tee -a ${_local_jail}
	echo 'banaction = iptables-multiport' | sudo tee -a ${_local_jail}
	echo '## Un-comment bellow and comment above to use hosts deny instead of iptables-multiport action by default.' | sudo tee -a ${_local_jail}
	echo '#banaction = route' | sudo tee -a ${_local_jail}
	echo '# email action. Since 0.8.1 upstream fail2ban uses sendmail' | sudo tee -a ${_local_jail}
	echo '# MTA for the mailing. Change mta configuration parameter to mail' | sudo tee -a ${_local_jail}
	echo '# if you want to revert to conventional 'mail'.' | sudo tee -a ${_local_jail}
	echo 'mta = sendmail' | sudo tee -a ${_local_jail}
	echo '# Default protocol' | sudo tee -a ${_local_jail}
	echo 'protocol = tcp' | sudo tee -a ${_local_jail}
	echo '# Specify chain where jumps would need to be added in iptables-* actions' | sudo tee -a ${_local_jail}
	echo 'chain = INPUT' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# Action shortcuts. To be used to define action parameter' | sudo tee -a ${_local_jail}
	echo '# The simplest action to take: ban only' | sudo tee -a ${_local_jail}
	echo 'action_ = %(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]' | sudo tee -a ${_local_jail}
	echo '# ban & send an e-mail with whois report to the destemail.' | sudo tee -a ${_local_jail}
	echo 'action_mw = %(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]' | sudo tee -a ${_local_jail}
	echo '              %(mta)s-whois[name=%(__name__)s, dest="%(destemail)s", protocol="%(protocol)s", chain="%(chain)s"]' | sudo tee -a ${_local_jail}
	echo '# ban & send an e-mail with whois report and relevant log lines' | sudo tee -a ${_local_jail}
	echo '# to the destemail.' | sudo tee -a ${_local_jail}
	echo 'action_mwl = %(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]' | sudo tee -a ${_local_jail}
	echo '               %(mta)s-whois-lines[name=%(__name__)s, dest="%(destemail)s", logpath=%(logpath)s, chain="%(chain)s"]' | sudo tee -a ${_local_jail}
	echo '# Choose default action.  To change, just override value of 'action' with the' | sudo tee -a ${_local_jail}
	echo '# interpolation to the chosen action shortcut (e.g.  action_mw, action_mwl, etc) in jail.local' | sudo tee -a ${_local_jail}
	echo '# globally (section [DEFAULT]) or per specific section' | sudo tee -a ${_local_jail}
	echo 'action = %(action_)s' | sudo tee -a ${_local_jail}
	echo '## Above ends default actions and settings bellow beguins custom, per jail/filter settings.' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# JAILS' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# Next jails corresponds to the standard configuration in Fail2ban 0.6 which' | sudo tee -a ${_local_jail}
	echo '# was shipped in Debian. Enable any defined here jail by including' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# [SECTION_NAME]' | sudo tee -a ${_local_jail}
	echo '# enabled = true' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# in /etc/fail2ban/jail.local.' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# Optionally you may override any other parameter (e.g. banaction,' | sudo tee -a ${_local_jail}
	echo '# action, port, logpath, etc) in that section within jail.local' | sudo tee -a ${_local_jail}
	echo '####' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# SSH server filter assignments' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '[ssh]' | sudo tee -a ${_local_jail}
	echo 'enabled = true' | sudo tee -a ${_local_jail}
	echo 'filter = sshd' | sudo tee -a ${_local_jail}
	echo 'port = ssh' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=ssh]' | sudo tee -a ${_local_jail}
	echo 'logpath  = /var/log/auth.log*' | sudo tee -a ${_local_jail}
	echo 'maxretry = 1' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[ssh-ddos]' | sudo tee -a ${_local_jail}
	echo 'enabled  = true' | sudo tee -a ${_local_jail}
	echo 'port     = ssh' | sudo tee -a ${_local_jail}
	echo 'filter   = sshd-ddos' | sudo tee -a ${_local_jail}
	echo 'logpath  = /var/log/auth.log*' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=sshddos]' | sudo tee -a ${_local_jail}
	echo 'maxretry = 1' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '####' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# HTTP & HTTPS server filter assignments 1' | sudo tee -a ${_local_jail}
	echo '## 	These are only slighly modifide from defaults provided by fail2ban' | sudo tee -a ${_local_jail}
	echo '[apache]' | sudo tee -a ${_local_jail}
	echo 'enabled  = true' | sudo tee -a ${_local_jail}
	echo 'port     = http,https' | sudo tee -a ${_local_jail}
	echo 'filter   = apache-auth' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=apache]' | sudo tee -a ${_local_jail}
	echo 'logpath  = /var/log/apache*/*error.log*' | sudo tee -a ${_local_jail}
	echo 'maxretry = 2' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[apache-noscript]' | sudo tee -a ${_local_jail}
	echo 'enabled  = true' | sudo tee -a ${_local_jail}
	echo 'port     = http,https' | sudo tee -a ${_local_jail}
	echo 'filter   = apache-noscript' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=noscript]' | sudo tee -a ${_local_jail}
	echo 'logpath  = /var/log/apache*/*error.log*' | sudo tee -a ${_local_jail}
	echo 'maxretry = 2' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[apache-overflows]' | sudo tee -a ${_local_jail}
	echo 'enabled  = true' | sudo tee -a ${_local_jail}
	echo 'port     = http,https' | sudo tee -a ${_local_jail}
	echo 'filter   = apache-overflows' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=overflow]' | sudo tee -a ${_local_jail}
	echo 'logpath  = /var/log/apache*/*error.log*' | sudo tee -a ${_local_jail}
	echo 'maxretry = 2' | sudo tee -a ${_local_jail}
	echo 'findtime = 6000' | sudo tee -a ${_local_jail}
	echo 'bantime  = 6000' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[apache-nourl]' | sudo tee -a ${_local_jail}
	echo 'enabled = true' | sudo tee -a ${_local_jail}
	echo 'port = http,https' | sudo tee -a ${_local_jail}
	echo 'filter = apache-nourl' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=nourl]' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/apache*/*error.log*' | sudo tee -a ${_local_jail}
	echo 'maxretry = 2' | sudo tee -a ${_local_jail}
	echo 'findtime = 6000' | sudo tee -a ${_local_jail}
	echo 'bantime  = 6000' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[apache-selfsrv]' | sudo tee -a ${_local_jail}
	echo 'enabled = true' | sudo tee -a ${_local_jail}
	echo 'filter = apache-selfsrv' | sudo tee -a ${_local_jail}
	echo 'port = http,https' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=selfsrv]' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/apache*/*error.log*' | sudo tee -a ${_local_jail}
	echo 'maxretry = 1' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[apache-postflood]' | sudo tee -a ${_local_jail}
	echo 'enabled = true' | sudo tee -a ${_local_jail}
	echo 'port = http,https' | sudo tee -a ${_local_jail}
	echo 'filter = apache-postflood' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=pflood]' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/apache*/*access.log*' | sudo tee -a ${_local_jail}
	echo 'maxretry = 5' | sudo tee -a ${_local_jail}
	echo 'findtime = 60' | sudo tee -a ${_local_jail}
	echo 'bantime = 6000' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '####' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# HTTP & HTTPS server filter assignments 2' | sudo tee -a ${_local_jail}
	echo '##	These are hevelly modifide from fail2ban & elsewhere, and designed to work with apache2 VHosts files that log attempts to seperate log files.' | sudo tee -a ${_local_jail}
	echo '##	The following aggressivly ban scanner bots and hacking attempts that use you server's IP address by reading those custom logs.' | sudo tee -a ${_local_jail}
	echo '##	Some of these jails/filters also read from both by using * to match all error files generated by all VHost files to prevent the more inteligent bots at bay.' | sudo tee -a ${_local_jail}
	echo '[apache-ipscan]' | sudo tee -a ${_local_jail}
	echo 'enabled  = true' | sudo tee -a ${_local_jail}
	echo 'port = http,https' | sudo tee -a ${_local_jail}
	echo 'filter = apache-ipscan' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/apache*/*error_ip*' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=ipscan]' | sudo tee -a ${_local_jail}
	echo 'maxretry = 1' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[apache-myphp]' | sudo tee -a ${_local_jail}
	echo 'enabled  = true' | sudo tee -a ${_local_jail}
	echo 'port = http,https' | sudo tee -a ${_local_jail}
	echo 'filter = apache-nourl' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/apache*/error*.lo*' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=myphp]' | sudo tee -a ${_local_jail}
	echo 'maxretry = 1' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[apache-nohome]' | sudo tee -a ${_local_jail}
	echo 'enabled  = true' | sudo tee -a ${_local_jail}
	echo 'port     = http,https' | sudo tee -a ${_local_jail}
	echo 'filter   = apache-nohome' | sudo tee -a ${_local_jail}
	echo 'logpath  = /var/log/apache*/*error*.log*' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=nohome]' | sudo tee -a ${_local_jail}
	echo 'maxretry = 2' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[apache-badbots]' | sudo tee -a ${_local_jail}
	echo 'enabled  = true' | sudo tee -a ${_local_jail}
	echo 'port     = http,https' | sudo tee -a ${_local_jail}
	echo 'filter   = apache-badbots' | sudo tee -a ${_local_jail}
	echo 'logpath  = /var/log/apache*/*error*.lo*' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=badbots]' | sudo tee -a ${_local_jail}
	echo 'maxretry = 1' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[php-url-fopen]' | sudo tee -a ${_local_jail}
	echo 'enabled = true' | sudo tee -a ${_local_jail}
	echo 'filter = php-url-fopen' | sudo tee -a ${_local_jail}
	echo 'port = http,https' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/apache*/*.log*' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=phpfopen]' | sudo tee -a ${_local_jail}
	echo 'maxretry = 1' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '####' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# ShellShock banning for servers' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '##	Apache instaban hosts scanning for shellshock vulnerability. This does NOT prevent ShellShock exploits from running on a vurnirable server.' | sudo tee -a ${_local_jail}
	echo '##	Instead this is aimed to prevent further exploits from being entertained by your server to an IP address that has made mal-intintions so clear.' | sudo tee -a ${_local_jail}
	echo '[apache-shellshock-scan]' | sudo tee -a ${_local_jail}
	echo 'enabled = true' | sudo tee -a ${_local_jail}
	echo 'filter = shellshock-scan' | sudo tee -a ${_local_jail}
	echo '## Option 1 - email only' | sudo tee -a ${_local_jail}
	echo '#action = sendmail-whois[name=shellshock-scan, dest=root@yourdomain.com, sender=fail2ban@yourdomain.com]' | sudo tee -a ${_local_jail}
	echo '## Option 2 - email and block' | sudo tee -a ${_local_jail}
	echo '#action = iptables-repeater[name=shock-scan]' | sudo tee -a ${_local_jail}
	echo '#sendmail-whois[name=shellshock-scan, dest=root@yourdomain.com, sender=fail2ban@yourdomain.com]' | sudo tee -a ${_local_jail}
	echo '## Option 3 - block without email' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=shock-scan]' | sudo tee -a ${_local_jail}
	echo '## Note option 3 is deafault as email servers are not always installed or configured properly.' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/apache2/*/*access.log*' | sudo tee -a ${_local_jail}
	echo 'maxretry = 1' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '## SSH instaban hosts scanning for shellshock vulnerability' | sudo tee -a ${_local_jail}
	echo '[ssh-shellshock-scan]' | sudo tee -a ${_local_jail}
	echo 'enabled = true' | sudo tee -a ${_local_jail}
	echo 'filter = shellshock-scan' | sudo tee -a ${_local_jail}
	echo '## Option 1 - email only' | sudo tee -a ${_local_jail}
	echo '#action = sendmail-whois[name=shellshock-scan, dest=root@yourdomain.com, sender=fail2ban@yourdomain.com]' | sudo tee -a ${_local_jail}
	echo '## Option 2 - email and block' | sudo tee -a ${_local_jail}
	echo '#action = iptables-repeater[name=shock-scan]' | sudo tee -a ${_local_jail}
	echo '#sendmail-whois[name=shellshock-scan, dest=root@yourdomain.com, sender=fail2ban@yourdomain.com]' | sudo tee -a ${_local_jail}
	echo '## Option 3 - block' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=shock-scan]' | sudo tee -a ${_local_jail}
	echo '## Note option 3 is deafault as email servers are not always installed or configured properly.' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/*auth.log*' | sudo tee -a ${_local_jail}
	echo 'maxretry = 1' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '####' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# WootWoot' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '##	' | sudo tee -a ${_local_jail}
	echo '[apache-wootwoot] ' | sudo tee -a ${_local_jail}
	echo 'enabled = true ' | sudo tee -a ${_local_jail}
	echo 'filter = apache-wootwoot ' | sudo tee -a ${_local_jail}
	echo 'action = iptables[name=HTTP, port="80,443", protocol=tcp] ' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/apache2/error.log ' | sudo tee -a ${_local_jail}
	echo 'maxretry = 1 ' | sudo tee -a ${_local_jail}
	echo 'bantime = 864000 ' | sudo tee -a ${_local_jail}
	echo 'findtime = 3600' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '####' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '# WordPress banning filters' | sudo tee -a ${_local_jail}
	echo '#' | sudo tee -a ${_local_jail}
	echo '##	Compleatly optional and these require that you have modified two files within your WordPress's source code.' | sudo tee -a ${_local_jail}
	echo '##	These settings are a bit more fergiving then the previous jails/filters as by default fail2ban is only looking 5 minuets into the past' | sudo tee -a ${_local_jail}
	echo '##		but it'll still ban offenders for 1 year.' | sudo tee -a ${_local_jail}
	echo '[apache-wp-login]' | sudo tee -a ${_local_jail}
	echo 'enabled = true ' | sudo tee -a ${_local_jail}
	echo 'port = http,https ' | sudo tee -a ${_local_jail}
	echo 'filter = apache-wp-login ' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=wp-login]' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/apache*/*error.log ' | sudo tee -a ${_local_jail}
	echo 'maxretry = 3 ' | sudo tee -a ${_local_jail}
	echo 'findtime = 600' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[apache-phpmyadmin] ' | sudo tee -a ${_local_jail}
	echo '#action = %(action_mwl)s ' | sudo tee -a ${_local_jail}
	echo 'enabled = true ' | sudo tee -a ${_local_jail}
	echo 'port = http,https ' | sudo tee -a ${_local_jail}
	echo 'filter = apache-phpmyadmin ' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=phpadmin]' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/apache*/*error.log ' | sudo tee -a ${_local_jail}
	echo 'maxretry = 1 ' | sudo tee -a ${_local_jail}
	echo 'findtime = 600' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[apache-wp-timthumb] ' | sudo tee -a ${_local_jail}
	echo '#action = %(action_mwl)s ' | sudo tee -a ${_local_jail}
	echo 'enabled = true ' | sudo tee -a ${_local_jail}
	echo 'port = http,https ' | sudo tee -a ${_local_jail}
	echo 'filter = apache-wp-timthumb ' | sudo tee -a ${_local_jail}
	echo 'action = iptables-repeater[name=timthumb]' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/apache*/*error.log ' | sudo tee -a ${_local_jail}
	echo 'maxretry = 1 ' | sudo tee -a ${_local_jail}
	echo 'findtime = 600' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[dovecot]' | sudo tee -a ${_local_jail}
	echo 'enabled = true' | sudo tee -a ${_local_jail}
	echo 'filter = dovecot' | sudo tee -a ${_local_jail}
	echo 'action = iptables-multiport[name=Dovecot, port="110,995,143,993", protocol=tcp]' | sudo tee -a ${_local_jail}
	echo '## Modify your_email@yourdomain.com before uncommenting' | sudo tee -a ${_local_jail}
	echo '#sendmail-whois[name=Dovecot, dest=your_email@your_domain.com, sender=fail2ban@mail.com]' | sudo tee -a ${_local_jail}
	echo '## Modify log path if non-standerd' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/secure' | sudo tee -a ${_local_jail}
	echo 'maxretry = 3' | sudo tee -a ${_local_jail}
	echo 'findtime = 600' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
	echo '[squirrelmail]' | sudo tee -a ${_local_jail}
	echo 'enabled = true' | sudo tee -a ${_local_jail}
	echo 'port = http,https' | sudo tee -a ${_local_jail}
	echo 'filter = squirrelmail' | sudo tee -a ${_local_jail}
	echo '#logpath = /var/log/squirrelmail.log' | sudo tee -a ${_local_jail}
	echo 'logpath = /var/log/syslog' | sudo tee -a ${_local_jail}
	echo 'bantime = 300' | sudo tee -a ${_local_jail}
	echo 'maxretry = 4' | sudo tee -a ${_local_jail}
	echo 'findtime = 600' | sudo tee -a ${_local_jail}
	echo '' | sudo tee -a ${_local_jail}
}
### Write_fail2ban_jail_local_help write_fail2ban_jail_local_help write_fail2ban_jail_local.sh
#	File ${_script_dir}/functions/fail2ban/config_writers/write_fail2ban_jail_local.sh
#	Option | Variable | Default | Notes
#	-------|----------|---------|------
#	-F2BD= | _fail2ban_dir | /etc | Sets base directory to look for `/etc/fail2ban`
#
####

