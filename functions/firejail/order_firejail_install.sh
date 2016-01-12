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
			
		;;
		client*)
			
		;;
		exit*)
			
		;;
		relay*)
			
		;;
		service*)
			
		;;
		esac
	done
	#Firejail_setup_jailed_network ##
	#Firejail_signin_privet #"${_firejail_args:---help='Order_firejail_install,Firejail_signin_privet' --exit='# [Firejail_signin_privet] # Failed to be read arguments'}"
#"${_firejail_args:---help='Order_firejail_install' --exit='# [Order_firejail_install] # Failed to be read arguments'}"

}
### Order_firejail_install_help order_firejail_install_help order_firejail_install.sh
#	File:	${_script_dir}/functions/firejail/order_firejail_install.sh
####
