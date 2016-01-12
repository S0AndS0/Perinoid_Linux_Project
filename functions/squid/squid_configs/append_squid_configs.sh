Append_squid_configs(){
	Arg_checker "${@:---help='Append_squid_configs' --exit='# [Append_squid_configs] # Failed to be read arguments'}" -ep='Append_squid_configs'
	_squid_count_total="${_connection_count:-8}"
	_squid_conf_dir="${_squid_dir:-/etc}/squid"
	Overwrite_config_checker "${_squid_conf_dir}/squid3.conf"
	echo "## Appending the following settings to the end of squid3.conf file"
	for _squid_count in {1..$_squid_count_total}; do
		if [ "$_squid_count" = "1" ]; then
			echo "cache_peer localhost parent 110${_squid_count}0 0 round-robin no-query" | sudo tee -a $_squid_conf_dir/squid.conf
		elif [ "$_squid_count" != "1" ]; then
			echo "cache_peer localhost_${_squid_count} parent 110${_squid_count}0 0 round-robin no-quary" | sudo tee -a $_squid_conf_dir/squid.conf
		else
			echo "## Error: Append_squid_config did NOT count $_squid_count"
		fi
	done
	echo "always-direct deny all" | sudo tee -a $_squid_conf_dir/squid.conf
}
### Append_squid_configs_help append_squid_configs_help append_squid_configs.sh
#	File:	${_script_dir}/functions/squid/squid_configs/append_squid_configs.sh
#	Argument	Variable		Default
#	[-C=...]	_connection_count	8
#	[-SqD=...]	_squid_dir		/etc
####
