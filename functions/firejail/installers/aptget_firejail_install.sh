Aptget_firejail_install(){
	Arg_checker "${@:---help='Aptget_firejail_install' --exit='# [Aptget_firejail_install] # Failed to be read arguments'}" -ep='Aptget_firejail_install'
	_firejail_deb_line="deb http://ftp.de.debian.org/debian stretch main"
	if ! [ -f "/etc/apt/sources.list.d/sid_stretch.list" ]; then
		echo "## [Aptget_firejail_install] had to write [${_firejail_deb_line}]"
		echo "#	to [/etc/apt/sources.list.d/sid_stretch.list]"
		echo '${_firejail_deb_line}' | sudo tee -a /etc/apt/sources.list.d/sid_stretch.list
		Fix_Apt_Keys "${@:---help='Fix_Apt_Keys' --exit='# [Fix_Apt_Keys] # Failed to be passed arguments'}"
	fi
	Install_Apt "${_application_list}" 'stretch' 'yes' || Arg_checker --help='Aptget_firejail_install,Install_Apt' --exit="# [Aptget_firejail_install] # Failed to install ${_applications_list}"
}
### Aptget_firejail_install_help aptget_firejail_install_help aptget_firejail_install.sh
#	File:	${_script_dir}/functions/firejail/installers/aptget_firejail_install.sh
####
