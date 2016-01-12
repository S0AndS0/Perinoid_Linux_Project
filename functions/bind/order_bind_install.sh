Order_bind_install(){
	_install_bind_args="${@:---help='Order_bind_install' --exit='# [Order_bind_install] # Failed to be read arguments'}"
	Arg_checker "${_install_bind_args}" -ep='Order_bind_install'
	case ${_install_method} do
	apt-get|aptget|safe)
		Aptget_bind_install "${_install_bind_args:---help='Order_bind_install,Aptget_bind_install' --exit='# [Aptget_bind_install] # Failed to read arguments'}"
	;;
	source|experoment)
		Source_bind_install "${_install_bind_args:---help='Order_bind_install,Source_bind_install' --exit='# [Source_bind_install] # Failed to read arguments'}"
	;;
	*)
		Arg_checker --help='Order_bind_install,Arg_checker' --exit='#Reading arguments though [Aptget_bind_install] and [Source_bind_install] #Failed'
	;;
	esac
	Write_bind_named_config "${_install_bind_args:---help='Order_bind_install,Write_bind_named_config' --exit='# [Write_bind_named_config] # Failed to read arguments'}"
	Write_bind_named_empty "${_install_bind_args:---help='Order_bind_install,Write_bind_named_empty' --exit='# [Write_bind_named_empty] # Failed to read arguments'}"
	Write_bind_named_tor_logging "${_install_bind_args:---help='Order_bind_install,Write_bind_tor_logging' --exit='# [Write_bind_tor_logging] # Failed to read arguments'}"
	Write_bind_named_tor_options "${_install_bind_args:---help='Order_bind_install,Write_bind_tor_options' --exit='# [Write_bind_tor_options] # Failed to read arguments'}"
	Write_bind_named_tor_zones "${_install_bind_args:---help='Order_bind_install,Write_bind_tor_zones' --exit='# [Write_bind_tor_zones] # Failed to read arguments'}"
	#Write_bind_onion "${_install_bind_args:---help='Order_bind_install,Write_bind_onion' --exit='# [Write_bind_onion] # Failed to read arguments'}"
	Resolv_conf_bind "${_install_bind_args:---help='Order_bind_install,Resolv_conf_bind' --exit='# [Resolv_conf_bind] # Failed to read arguments'}"
#${_install_bind_args:---help='Order_bind_install,' --exit='# [] # Failed to read arguments'}
	
	Start_service "named" "${_bind9_dir:-/etc}"
	for _tor_node_type in ${_tor_node_types//#/ }; do
		case ${_tor_node_type} in
		client)
			echo "## Notice [Order_bind_install] advises that [${USER}] neads to set"
			echo "#	primary DNS and secondary DNS to [127.0.0.1] IP address."
			echo '#	Generally found under "Network Configuration Tool" this setting'
			echo '#	can be modifide and a [service networking restart] command issued'
			echo '#	to prevent DNS leaks after [Order_bind_install] is finished.'
		;;
		esac
	done
}
### Order_bind_install_help order_bind_install_help order_bind_install.sh
#	File:	${_script_dir}/functions/bind/order_bind_install.sh
#	Argument	Variable		Default
#	[-I=...]	_install_method		aptget
#	[-T=...]	_tor_node_types		client
#	Notes:	This function is Not tested, the source installer may not work and configurations maybe
#		out of date or not applicable for current Tor node type. Generally this should be used
#		if running as a [client] or [exit] Tor node service to prevent DNS leeks when a browser
#		requests an [~.onion] or [~.i2p] URL. Settings written by this function maybe quickly
#		reverted by copying the old [named.conf] file over the new one, though much care was taken
#		to resurch the correct configurations to write.
#		If running a [bridge] Tor node service that allows local network devices to attach then
#		consider running [unbound] as an argument to [${_script_name}] via the [-A='unbound']
#		option to install and configure that DNS service instead.
####
