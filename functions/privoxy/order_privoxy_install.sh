Order_privoxy_install(){
	Arg_checker "${@:---help='Order_privoxy_install' --exit='## Failed to be read arguments'}" -ep='Order_privoxy_install'
	case ${_install_method} in
	aptget|apt-get|safe)
		Aptget_privoxy_install "${@:---help='Aptget_privoxy_install' --exit='# [Aptget_privoxy_install] # Failed to be passed arguments'}"
	;;
	source|experoment)
		Add_privoxy_user "${@:---help='Add_privoxy_user' --exit='# [Add_privoxy_user] # Failed to be read arguments'"
		Source_privoxy_install "${@:---help='Source_privoxy_install' --exit='# [Source_privoxy_install] # Failed to be read arguemnts'}"
	;;
	*)
		Arg_checker --help='Order_privoxy_install' --exit='#Reading arguments through [Aptget_privoxy_install] and [Source_privoxy_install] # Failed'
	;;
	esac
	Privoxy_client_configs "${@:---help='Privoxy_client_configs' --exit='# [Privoxy_client_configs] # Failed to be read arguments'"
	Privoxy_init_client "${@:---help='Privoxy_init_client' --exit='# [Privoxy_init_client] # Failed to be read arguments'"
	Activate_privoxy_configs "${@:---help=Activate_privoxy_configs'' --exit='# [Activate_privoxy_configs] # Failed to be read arguemtns'}"
	Start_service "privoxy" "${_privoxy_dir}"
}
### Order_privoxy_install_help order_privoxy_install_help order_privoxy_instal.sh
#	File:	${_script_dir}/functions/privoxy/order_privoxy_install.sh
#	Argument	Variable		Default
#	[-I=...]	_install_method		aptget
####
