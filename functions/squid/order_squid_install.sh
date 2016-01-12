Order_squid_install(){
	_install_squid_args="${@:---help='Order_squid_install' --exit='# [Order_squid_install] # Failed to be read arguments'}"
	Arg_checker "${_install_squid_args}" -ep='Order_squid_install'
	case ${_install_method} in
	apt-get|aptget|safe)
		Aptget_squid_install "${_install_squid_args:---help='Order_squid_install,Aptget_squid_install' --exit='# [Aptget_squid_install] # Failed to be read arguments'}"
	;;
	source|experoment)
		Source_squid_install "${_install_squid_args:---help='Order_squid_install,Source_squid_install' --exit='# [Source_squid_install] # Failed to be read arguments'}"

	;;
	*)
		Arg_checker --help='Order_squid_install,Arg_checker' --exit='#Reading arguments through [] and [] # Failed'
	;;
	esac
	Append_squid_configs "${_install_squid_args:---help='Order_squid_install,Append_squid_configs' --exit='# [Append_squid_configs] # Failed to be read arguments'}"
	Write_squid_in_conf "${_install_squid_args:---help='Order_squid_install,Write_squid_in_conf' --exit='# [Write_squid_in_conf] # Failed to be read arguments'}"
	Write_squid_out_conf "${_install_squid_args:---help='Order_squid_install,Write_squid_out_conf' --exit='# [Write_squid_out_conf] # Failed to be read arguments'}"
	Refresh_squid_configs "${_install_squid_args:---help='Order_squid_install,Refresh_squid_configs' --exit='# [Refresh_squid_configs] # Failed to be read arguments'}"

}
### Order_squid_install_help order_squid_install_help order_squid_install.sh
#	File:	${_script_dir}/functions/squid/order_squid_install.sh
#	Argument	Variable		Default
#	[-I=...]	_install_method		aptget
#	Uses: If tor client option is chosen then bot this function and [Order_privoxy_install] function
#		should also be run. Squid is used to load balance between privoxy listening ports for
#		each port defined by [-C...] arguemnt passed to [${_script_name}]
####
