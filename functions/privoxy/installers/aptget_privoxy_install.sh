Aptget_privoxy_install(){
	Arg_checker "${@:---help='Aptget_privoxy_install' --exit='# [Aptget_privoxy_install] # Failed to be read arguments'}" -ep='Aptget_privoxy_install'
	for _node_types in ${_tor_node_type//#/ }; do
		case ${_node_types} in
		client*)
			Install_Apt "${_application_list:-privoxy}"
		;;
		esac
	done
}
### Aptget_privoxy_install_help aptget_privoxy_install_help aptget_privoxy_install.sh
#	File:	${_script_dir}/functions/privoxy/installers/aptget_privoxy_install.sh
#	Uses [Install_Apt] function to check before installing privoxy and any dependancies
#	This function should only fire if [-I='aptget'] and [-T='client'] are options
#	read by [${_script_name}]. Additional applications maybe added through the use
#	of [-A='...'] argument.
#	Argument	Variable		Default
#	[-T=...]	_tor_node_types		client
#	[-A=...]	_application_list	privoxy
####
