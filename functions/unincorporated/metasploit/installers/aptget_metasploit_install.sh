Aptget_metasploit_install(){
	Arg_checker "${@:---help='Aptget_metasploit_install' --exit='# [Aptget_metasploit_install] # Failed to be read arguments'}" -ep='Aptget_metasploit_install'
	echo "## Notice [Aptget_metasploit_install] sending [Parse_apt_priority function the value [kali]"
	Parse_apt_priority -AT="kali"
	echo "## Notice [Aptget_metasploit_install] sending apps [${_application_list}] to [Install_Apt] function..."
	Install_Apt "${_application_list}"
}
### Aptget_metasploit_install_hepl aptget_metasploit_install_help aptget_metasploit_install.sh
#	File:	${_script_dir}/functions/metasploit/installers/aptget_metasploit_install.sh
#	Argument	Variable			Usage
#	-A			_application_list	Sets the applications to install and be written to [/etc/apt/preferances.d/] directory
#	-AT			_apt_target_release	Sets the value to be written to [/etc/apt/preferances.d/] directory
#	Used in combination this should allow for adding Kali's source lists to your distrobution without installing fully upgrading host distrobution.
#	Future installations with apt-get should make use of [-t] option to set what sources lists to use for various applications.
####
