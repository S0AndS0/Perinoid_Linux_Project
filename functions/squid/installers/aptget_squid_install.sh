Aptget_squid_install(){
	Arg_checker "${@:---help='Aptget_squid_install' --exit='# [Aptget_squid_install] # Failed to be read arguments'}" -ep='Aptget_squid_install'
	Install_Apt "${_application_list}" || Arg_checker --help='Install_Apt' --exit='# [Install_Apt] # Failed'
}
### Aptget_squid_install_help aptget_squid_install_help aptget_squid_install.sh
#	File:	${_script_dir}/functions/squid/installers/aptget_squid_install.sh
#	Argument	Variable		Default
#	[-A=...]	_application_list	squid3
####
