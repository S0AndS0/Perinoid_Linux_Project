Torrc_relay_configs(){
	Arg_checker "${@:---help='Torrc_relay_configs' --exit='# [Torrc_relay_configs] # Failed to be read arguments'}"
	_torrc_dir="${_tor_directory:-/etc}/tor"
	Overwrite_config_checker "${_tor_directory}/tor/torrc-${_tor_relay_nickname}"
	if ! [ -f ${_torrc_dir}/torrc-${_tor_relay_nickname} ]; then
		echo "Nickname ${_tor_relay_nickname}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo "ORPort ${_tor_or_port:-9001}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo 'ClientOnly 0' | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo 'SocksPort 0' | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo 'Log notice stout' | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo 'ControlPort 9051' | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo 'CookieAuthentication 1' | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo "RelayBadwidthRate ${_tor_relay_bandwith_rate:-5} Mbits" | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo "RelayBadwidthBurst ${_tor_relay_bandwith_burst:-10} Mbits" | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo "#ContactInfo ${_email_address} - ${_btc_address}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo "DirPort ${_tor_dir_port:-80}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo "DirPortFrountPage ${_tor_dir}/tor-exit-notic.html" | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo '#MyFamily $($KEYID),$($KEYID)...' | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo "ExitPolicy reject ${_external_ipv4}:*" | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo "ExitPolicy reject ${_nat_ipv4}:*" | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo "User ${_tor_user}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo 'DisableDebuggerAttachment 0' | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo 'AvoidDiskWrites 1' | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo 'DisableAllSwap 1' | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo 'HardwareAccel 1' | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
		echo 'NumCPUs 2' | sudo tee -a ${_torrc_dir}/torrc-${_tor_relay_nickname}
	fi
#	echo "" | tee -a ${_torrc_dir}/tor-${_tor_relay_nickname}
#	echo '' | tee -a ${_torrc_dir}/tor-${_tor_relay_nickname}
}

### Torrc_relay_configs_help torrc_relay_configs_help torrc_relay_configs.sh
#	File:	${_script_dir}/functions/tor/torrc_writers/torrc_relay_configs.sh
#	This function utilises [-D=...] for where to find [/etc] directory to look
#	for [/tor] sub directory. And [-EA=...] for contact info.
#	Try enclosing the email address in quotes so that spaces and other charictars
#	can be used to obsfucate, ei [-EA='email address at domain name dot com']
#	instead of [-EA=emailaddress@domainname.com] additionally the [-BA=...]
#	if set will display your chosen crypto currency address.
####
