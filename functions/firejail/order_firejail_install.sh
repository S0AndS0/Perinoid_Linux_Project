Order_firejail_install(){
	_firejail_args="${@:---help='Order_firejail_install' --exit='# [Order_firejail_install] # Failed to be read arguments'}"
	Arg_checker "${_firejail_args}" -ep='Order_firejail_install'
	case ${_install_method} in
	aptget|apt-get|safe)
		Aptget_firejail_install "${_firejail_args:---help='Order_firejail_install,Aptget_firejail_install' --exit='# [Order_firejail_install] # Failed pass arguments to [Aptget_firejail_install]'}"
	;;
	source|experoment)
		Source_firejail_install "${_firejail_args:---help='Order_firejail_install,Source_firejail_install' --exit='# [Order_firejail_install] # Failed pass arguments to [Source_firejail_install]'}"
	;;
	*)
		Arg_checker --help="Order_firejail_install,Aptget_firejail_install,Source_firejail_install" --exit="#Reading arguments through [Aptget_firejail_install] or [Source_firejail_install] failed"
	;;
	esac
	for _node_type in ${_tor_node_types//#/ }; do
		case ${_node_type} in
		bridge*)
			#Firejail_setup_jailed_network -FBF="" -FBI="" -FHI="" -FBipv4="" -FNipv4=""
		;;
		client*)
			#Firejail_setup_jailed_network -FBF="" -FBI="" -FHI="" -FBipv4="" -FNipv4=""
		;;
		exit*)
			#Firejail_setup_jailed_network -FBF="" -FBI="" -FHI="" -FBipv4="" -FNipv4=""
		;;
		relay*)
			#Firejail_setup_jailed_network -FBF="" -FBI="" -FHI="" -FBipv4="" -FNipv4=""
		;;
		service*)
			#Firejail_setup_jailed_network -FBF="" -FBI="" -FHI="" -FBipv4="" -FNipv4=""
		;;
		esac
	done
	#Firejail_setup_jailed_network ##
	#Firejail_signin_privet #"${_firejail_args:---help='Order_firejail_install,Firejail_signin_privet' --exit='# [Firejail_signin_privet] # Failed to be read arguments'}"
#"${_firejail_args:---help='Order_firejail_install' --exit='# [Order_firejail_install] # Failed to be read arguments'}"

}
### Order_firejail_install_help order_firejail_install_help order_firejail_install.sh
#	File:	${_script_dir}/functions/firejail/order_firejail_install.sh
#	Argument	Variable			Default
#	[-B=...]	_tor_bridge_nickname 		Bridge_Node
#	[-E=...]	_tor_exit_nickname 			Exit_Node
#	[-FBF=...]	_firejail_bridge_forward	enabled
#	[-FBI=...]	_firejail_bridge_interface	br0
#	[-FHI=...]	_firejail_host_interface	eth0
#	[-FSN=...]	_firejail_service_name		nginx
#	[-FBipv4=...]	_firejail_bridge_ipv4	10.10.20.1
#	[-FNipv4=...]	_firejail_nat_ipv4		10.10.20.0
#	[-R=...]		_tor_relay_nickname 	Relay_Node
#	[-T=...]		_tor_node_types 		client
####
