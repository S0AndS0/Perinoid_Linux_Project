Aptget_polipo_install(){
	Arg_checker "${@:---help='Aptget_polipo_install' --exit='# [Aptget_polipo_install] # Failed to be read arguments'}" -ep='Aptget_polipo_install'
	Install_Apt "${_application_list}"
}
### Aptget_polipo_install_help aptget_polipo_install_help aptget_polipo_install.sh
#	File:	${_script_dir}/functions/polipo/installers/aptget_polipo_install.sh
#	This function should only be called if [${_script_name}] detects [-I='aptget']
#	and [-A='polipo'] as arguments passed.
####
