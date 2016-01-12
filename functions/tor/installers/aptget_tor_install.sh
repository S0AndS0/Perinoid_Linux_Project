Aptget_tor_install(){
	Arg_checker "${@:---help='Aptget_tor_install' --exit='# [Aptget_tor_install] # Failed to be read agruments'}" -ep='Aptget_tor_install'
	if ! [ -f "/etc/apt/sources.list.d/tor.list" ]; then
		echo "## Notice : Aptget_tor_install adding the following link..."
		echo "#	deb http://deb.torproject.org/torproject.org ${_dist_id_nice} main"
		echo "#	...to /etc/apt/sources.list.d/tor.list"
		echo "deb http://deb.torproject.org/torproject.org ${_dist_id_nice} main" | sudo tee -a /etc/apt/sources.list.d/tor.list
		Fix_Apt_Keys "${@:---help='Fix_Apt_Keys' --exit='# [Fix_Apt_Keys] # Failed to recive arguments'}"
	fi
	Install_Apt "${_application_list}" '' 'yes' || Arg_checker --help='Install_Apt' --exit='# [Install_Apt] # Failed'
}
### Aptget_tor_install_help aptget_tor_install_help aptget_tor_install.sh
#	File:	${_script_dir}/functions/tor/installers/aptget_tor_install $1
#	This function is called if [${_script_name}] detects [-A='tor'] and [-I='aptget']
#	and [-T='client'] as arguments passed.
####
