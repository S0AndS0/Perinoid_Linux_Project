Activate_privoxy_configs(){
	Arg_checker "${@:---help='Activate_privoxy_configs' --exit='# [Activate_privoxy_configs] # Failed to be read arguments'}" -ep='Activate_privoxy_configs'
	for _privoxy_count in {1..$_connection_count}; do
		echo "## Activating privoxy ${_privoxy_count} conection, logging and configurations"
		sudo install -o ${_privoxy_user:-privoxy} -g nogroup -m 750 -d /var/log/privoxy_${_privoxy_count}
	done
	echo "## Notice [Activate_privoxy_configs] function finnished with [1-${_privoxy_count_total}] activations"
}
### Activate_privoxy_configs_help activate_privoxy_configs_help activate_privoxy_configs.sh
#	File:	${_script_dir}/functions/privoxy/lib_activations/activate_privoxy_configs.sh
#	Reads one aregument set by [-C='8'] argument fead to [${_script_name}] script.
#	This function should be one of the last fired to configure privoxy for multiple
#	client connections. Only activated if [${_script_name}] detects [-T="client"]
#	as an argument.
#	Argument	Variable		Default
#	[-C=...]	_connection_count	8
#	[-PU=...]	_privoxy_user		privoxy
####
