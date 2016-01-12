Aptget_bind_install(){
	Arg_checker "${@:---help='' --exit=''}" -ep='Aptget_bind_install'
	Install_Apt "${_application_list}"
}
### Aptget_bind_install_help aptget_bind_install_help aptget_bind_install.sh
#	File:	${_script_dir}/functions/bind/installers/aptget_bind_install.sh
####
