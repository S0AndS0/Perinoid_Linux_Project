Order_polipo_install(){
	Arg_checker "${@:---help='Order_polipo_install' --exit='# [Order_polipo_install] # failed to be read agruments'}" -ep='Order_polipo_install'
	case ${_install_method} in
	aptget|apt-get|safe)
		Aptget_polipo_install "${@:---help='Order_polipo_install,Aptget_polipo_install' --exit='# [Aptget_polipo_install] # Failed to be passed arguments'}"
	;;
	source|experoment)
		Add_polipo_user "${@:---help='Order_polipo_install,Add_polipo_user' --exit='# [Add_polipo_user] # Failed to be passed arguments'}"
		Source_polipo_install "${@:---help='Order_polipo_install,Add_polipo_user' --exit='# [Source_polipo_install] # Failed to be passed arguments'}"
		Polipo_init_client "${@:---help='Order_polipo_install,Polipo_init_client' --exit='# [Polipo_init_client] # Failed to be passed arguments'}"
	;;
	*)
		Arg_checker --help="" --exit=""
	;;
	esac
	Append_polipo_configs "${@:---help='Order_polipo_install,Append_polipo_configs' --exit='# [Append_polipo_configs] # Failed to be passed arguments'}"
}
### Order_polipo_install_help order_polipo_install_help order_polipo_install.sh
#	File:	${_script_dir}/functions/polipo/order_polipo_install.sh
#	
####
