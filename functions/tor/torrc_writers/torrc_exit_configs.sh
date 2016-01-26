Torrc_exit_configs(){
	Arg_checker "${@:---help='Torrc_exit_configs' --exit='# [Torrc_exit_configs] # Failed to be read arguments'}" -ep='Torrc_exit_configs'
#	_exit_types=""
	_tor_dir="${_tor_directory:-/etc}/tor"
	Overwrite_config_checker "${_tor_directory}/tor/torrc-${_tor_exit_nickname}"
	echo 'ClientOnly 0' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	if [ "${#_external_ipv4}" != "0" ]; then
		echo "DirPort ${_external_ipv4}:${_tor_dir_port:-9030}" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	else
		echo "DirPort ${_tor_dir_port:-9030}" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	fi
	if [ "${#_nat_ipv4}" != "0" ]; then
		echo "Address ${_nat_ipv4}" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo "OutboundBindAddress ${_nat_ipv4}" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo "ORPort ${_nat_ipv4}:${_tor_or_port:-9001}" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	else
		echo "ORPort ${_tor_or_port:-9001}" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	fi
	echo "DataDirectory /var/lib/tor/tor${_tor_exit_nickname}" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo "PidFile /var/run/tor/tor${_tor_exit_nickname}" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo "Log notic file /var/log/tor/notices${_tor_exit_nickname}.log" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'RelayBadwidthRate 30 MBytes' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'RelayBandwidthBurst 100 MBytes' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExcluedSingleHopRelays 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo '## Identify/contact info' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo "Nickname ${_tor_exit_nickname}" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
#	echo '#MyFamily %MYFAMILY' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}

	echo "#ContactInfo https://some_url.some_domain/donate.html <support .AT. some_url .DOT. some_domain" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	if [ -f "/etc/tor/tor-exit-notice.html" ]; then
		if ! [ -d ${_tor_web_dir} ]; then
			mkdir -p ${_tor_web_dir}
		fi
		cp /etc/tor/tor-exit-notice.html ${_tor_web_dir}/tor-exit-notice.html
		echo "DirFrontPage ${_tor_web_dir}/tor-exit-notice.html" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	else
		echo "## Error : Torrc_exit_configs function could not find /etc/tor/tor-exit-notice.html"
		echo "#	on your system, leaving entry commented out in ${_tor_dir}torrc-${_tor_exit_nickname}"
		echo "#DirFrontPage /etc/tor/tor-exit-notice.html" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	fi
	echo 'CellStatistics 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'DirReqStatistics 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPortStatistics 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExtraInfoStatistics 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'HiddenServiceStatistics 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'SocksPort 0' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'SocksPolicy reject *' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'RunAsDaemon 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo "## IPv4 exit policies" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:22		# SSH' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:43		# WHOIS' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:53		# DNS' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:389		# LDAP' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:443		# HTTPS' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:464		# kpasswd' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:531		# IRC/AIM' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:543-544	# Kerberos' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:554		# RTSP' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:563		# NNTP over SSL' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:636		# LDAP over SSL' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:706		# SILC' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:749		# kerberos' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:873		# rsync' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:902-904	# Vmware' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:981		# Remote HTTPS management for firewall' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:989-995	# FTP over SSL, Network Administration System, telnets, IMAP over SSL, ircs, POP3 over SSL' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:1194		# OpenVPN' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:1220		# QT Server Admin' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:1293		# PKT-KRB-IPSec' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:1500		# VLSI Liscense Manager' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:1533		# Sametime' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:1677		# GroupWise' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:1723		# PPTP' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:1755		# RTSP' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:1863		# MSNP' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:4244		# whatsapp' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:5222-5223	# XMPP/Google Talk/Jabber/Apple iChat' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:5228-5230	# Google Cloud Messaging/Whatsapp/threema' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:6679		# IRC SSL' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:8332-8333	# BitCoin' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:8443		# PCsync HTTPS' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:10000		# Network Data Management Protocol' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:11371		# OpenPGP hkp (http keyserver protocol)' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:19294		# Google Voice TCP' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy accept *:64738		# MumbleExitPolicy' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	echo 'ExitPolicy reject *:*		# Reject All other unmatched ports' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	case ${_enable_ipv6} in
	yes|Yes)
		echo '## IPv6 exit policies' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'IPv6Exit 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		if [ "${#_nat_Ipv6}" != "0" ]; then
			echo "ORPort [${_nat_ipv6}]:${_tor_or_port:-9001}" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
			echo "OutboundBindAddress [${_nat_ipv6}]" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		else
			echo "ORPort ${_tor_or_port:-9001}" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		fi
		echo 'ExitPolicy accept6 *:22		# SSH' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:43		# WHOIS' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:53		# DNS' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:389		# LDAP' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:443		# HTTPS' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:464		# kpasswd' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:531		# IRC/AIM' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:543-544	# Kerberos' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:554		# RTSP' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:563		# NNTP over SSL' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:636		# LDAP over SSL' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:706		# SILC' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:749		# kerberos' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:873		# rsync' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:902-904	# Vmware' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:981		# Remote HTTPS management for firewall' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:989-995	# FTP over SSL, Network Administration System, telnets, IMAP over SSL, ircs, POP3 over SSL' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:1194		# OpenVPN' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:1220		# QT Server Admin' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:1293		# PKT-KRB-IPSec' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:1500		# VLSI Liscense Manager' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:1533		# Sametime' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:1677		# GroupWise' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:1723		# PPTP' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:1755		# RTSP' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:1863		# MSNP' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:4244		# whatsapp' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:5222-5223	# XMPP/Google Talk/Jabber/Apple iChat' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:5228-5230	# Google Cloud Messaging/Whatsapp/threema' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:6679		# IRC SSL' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:8332-8333	# BitCoin' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:8443		# PCsync HTTPS' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:10000		# Network Data Management Protocol' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:11371		# OpenPGP hkp (http keyserver protocol)' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:19294		# Google Voice TCP' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy accept6 *:64738		# MumbleExitPolicy' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
		echo 'ExitPolicy reject6 *:*		# Reject All other unmatched ports' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
	;;
	esac
#	echo "" | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
#	echo '' | sudo tee -a ${_tor_dir}/torrc-${_tor_exit_nickname}
}
### Torrc_exit_configs_help torrc_exit_configs.sh
## Torrc_exit_configs $1 $2 $3 $4 $5 $6 $7 $8 $9
## Torrc_exit_configs /etc/tor debian-tor Exit_Node $_external_ipv4 $_nat_ipv4 /var/www/tor no $_nat_ipv6
## Torrc_exit_configs /etc/tor debian-tor Exit_Node $_external_ipv4 192.168.1.5 /var/www/tor yes b4:a2:f9:c3:0a:3b
#	First argument is passed from Write_torrc_configs function's second argument, torrc config directory
#	Second argumennt is passed from Write_torrc_configs function's third argument, tor username [debian-tor]
#	Third argument is passed from Write_torrc_configs function's forth argument, [-T=] from install_tor.sh
#	This is then parced for what type of exit node you wish to run, ei [-T=exit-public]
#	Forth argument is passed from Write_torrc_configs function's fifth argument, tor exit node's nickname
#	Fifth argument is passed from Write_torrc_configs function's seventh argument, your system's external IP
#	Sixth argument is passed from Write_torrc_configs function's eighth argument, your system's NAT IP address
#	Seventh argument is passed from Write_torrc_configs function's nineth argument, the directory to copy
#	tor-exit-notic.html file to and write into torrc file for serving to those that connect back to your node
#	Note : both the forth and fifth's arguments for Torrc_exit_configs function are inherited from the
#	check_host_enviroment.sh script's function. The checking of your system's external IP address can be bypassed
#	by providing the main install_tor.sh script with [-ip="your-ip-here"] argument at run-time.
#	Seventh argument is passed from Write_torrc_configs function's tenth argument, [-D=] from install_tor.sh
#	Eighth argument is passed from Writ_torrc_configs function's eleventh argument, [-ipv6] from install_tor.sh
#	Nineth argument is enherited from check_host_enviroment.sh and passed from Write_torrc_configs function's
#	twowelthf argument.

