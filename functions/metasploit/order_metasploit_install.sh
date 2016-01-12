Order_metasploit_install(){
	Arg_checker "${@:---help='Order_metasploit_install' --exit='# [Order_metasploit_install] # Failed to be read arguments'}" -ep='Order_metasploit_install'
	case ${_install_method} in
	aptget|apt-get)
		#Aptget_metasploit_install ""
	;;
	source)
		#Source_metasploit_install ""
	;;
	esac
	
}
### Order_metasploit_install_help order_metasploit_install_help order_metasploit_install.sh
#	File:	${_scriipt_dir}/functions/metasploit/order_metasploit_install.sh
####
