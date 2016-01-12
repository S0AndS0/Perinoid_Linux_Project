Order_firetools_install(){
	_firetools_args="${@:---help='Order_firetools_install' --exit='# [Order_firetools_install] # Failed to be read arguments'}"
	Arg_checker "${_firetools_args}" -ep='Order_firetools_install'
	case ${_install_method} in
	aptget|apt-get|experoment)
		Aptget_firetools_install "${_firetools_args}"
	;;
	aptget|apt-get|experoment|source|safe)
		Source_firetools_install "${_firetools_args}"
	;;
	esac

#"${_firetools_args:---help='Order_firetools_install,' --exit='# [] # Failed to be read arguments'}"
}
### Order_firetools_install_help order_firetools_install_help order_firetools_install.sh
#	File:	${_script_dir}/functions/firetools/order_firetools_install.sh
####
