Order_nginx_install(){
	_nginx_args="${@:---help='Order_nginx_install' --exit='# [Order_nginx_install] # Failed to read arguments'}"
	Arg_checker "${_nginx_args}" -ep='Order_nginx_install'
	case ${_install_method} in
	aptget|apt-get|safe)
		Aptget_nginx_install "${_nginx_args}"
	;;
	source|experoment)
		Source_nginx_install "${_nginx_args}"
	;;
	*)
		echo "## Error [Order_nginx_install] failed to understand [${_script_name}] installation method [${_install_method}]"
		Arg_checker --help='Order_nginx_install' --exit='# [Order_nginx_install] # Failed to understand installation method.'
	;;
	esac
	Write_nginx_server_configs "${_nginx_args}"
	if [ "${#_nginx_url}" != "0" ]; then
		Write_nginx_server_block "${_nginx_args}"
	else
		echo "## Notice [Order_nginx_install] did Not detect a url passed via [-NU=\"${_nginx_url}\"]"
		echo "#	Passing control back to [${_script_name}]..."
	fi

}
### Order_nginx_install_help order_nginx_install_help order_nginx_install.sh
#	File:	${_script_dir}/functions/nginx/order_nginx_install.sh
####
