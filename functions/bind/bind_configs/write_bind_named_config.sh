Write_bind_named_config(){
	Arg_checker "${@:---help='Write_bind_config' --exit='# [Write_bind_config] # Failed to be read arguments'}" -ep='Write_bind_config'
	_path="${_bind9_dir:-/etc}/bind"
	Overwrite_configs_checker "${_path}/named.conf"
	echo "#	Writing the following lines to [${_bind9_conf_dir}/named.conf] file"
	echo "include \"${_path}/named.conf.tor;\"" | sudo tee -a ${_path}/named.conf
	echo "include \"${_path}/named.conf.tor.options;\"" | sudo tee -a ${_path}/named.conf
	echo "include \"${_path}/named.conf.tor.logging;\"" | sudo tee -a ${_path}/named.conf
	echo "include \"${_path}/named.conf.tor.zones;\"" | sudo tee -a ${_path}/named.conf
	## See [${_script_name} --help='Write_bind_onion'] for why this is not currently used
	#echo "include \"${_path}/onion;\"" | sudo tee -a ${_path}/named.conf
#	echo "" | sudo tee -a ${_path}/named.conf
}
### Write_bind_named_config_help write_bind_named_config_help write_bind_named_config.sh
#	File:	${_script_dir}/functions/bind/bind_configs/write_bind_named_config.sh
#	Argument	Variable		Default
#	[-B9D=...]	_bind9_dir		/etc
#	Notes:	Update root server list once per year for [/etc/named/named.ca] on [] based Linux distros
#		or [/etc/bind/named.ca] on [Debian] based Linux distros with the following command
#		[ dig @e.root-servers.net . ns ]
#		These servers rairly change, consider assigining a cron job if forgetfull.
####
