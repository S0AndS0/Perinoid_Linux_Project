Aptget_nginx_install(){
	Arg_checker "${@:---help='Aptget_nginx_install' --exit='# [Aptget_nginx_install] # Failed to be read arguments'}" -ep='Aptget_nginx_install'
	echo "## Notice [Aptget_nginx_install] sending apps [${_application_list}] to [Install_Apt] function..."
	Install_Apt "${_application_list}"
}
### Aptget_nginx_install_help aptget_nginx_install_help aptget_nginx_install.sh
#	File:	${_script_dir}/functions/nginx/installers/aptget_nginx_install.sh
###

