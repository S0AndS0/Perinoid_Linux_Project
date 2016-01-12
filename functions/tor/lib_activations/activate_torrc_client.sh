Activate_torrc_client(){
	Arg_checker "${@:---help='Activate_torrc_client' --exit='# [Activate_torrc_client] # Failed'}" -ep='Activate_torrc_client'
	echo "## Activating configs for [torrc-1] to [torrc-${_connection_count}] now."
	for _tor_count in {1..$_connection_count}; do
		echo "#	With lib file path under [/var/lib/tor_${_tor_bridge_nickname}]"
		sudo install -o ${_tor_user:-debian-tor} -g ${_tor_user:-debian-tor} -m 700 /var/lib/tor_client_${_tor_count} || Arg_checker --help='Activate_torrc_client' --exit='# [sudo install -o ${_tor_user:-debian-tor} -g ${_tor_user:-debian-tor} -m 700 /var/lib/tor_client_${_tor_count}] # Failed'
	done
}
### Activate_torrc_client_help activate_torrc_client_help activate_torrc_client.sh
#	File:	${_script_dir}/tor/functions/activate_services/activate_torrc_client.sh
#	This function is only run by [Activate_torrc_configs] function if [client]
#	is detected as an argument passed via [-T=client] to [${_script_name}]
#	Other arguments read into this function are [-U=${_tor_user:-debian-tor}]
#	and [-C=${_connection_count:-8}] This sets up the same number of 
#	[/var/lib/tor_client_\${_connection_count}] files as was passed to install_tor.sh script
#	to name custom directory paths
####
