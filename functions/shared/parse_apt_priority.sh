Parse_apt_priority(){
	Arg_checker "${@:---help='Parse_apt_priority' --exit='# [Parse_apt_priority] # Failed to be read arguments'}" -ep='Parse_apt_priority'
	if ! [ -f "/etc/apt/preferences.d/prevent_kernel_upgrades" ]; then
		echo "## Notice [Parse_apt_priority] has to write [/etc/apt/preferences.d/prevent_kernel_upgrades] file"
		echo 'Package: /(linux|nividia)/' | tee -a /etc/apt/preferences.d/prevent_kernel_upgrades
		echo 'Pin: release *' | tee -a /etc/apt/preferences.d/prevent_kernel_upgrades
		echo 'Pin-Priority: -5' | tee -a /etc/apt/preferences.d/prevent_kernel_upgrades
	fi
	if [ "${#_apt_target_release}" != "0" ]; then
		if [ "${#_application_list}" != "0" ]; then
			echo "Package: /(${_application_list//,/|})/" | tee -a /etc/apt/preferences.d/${_apt_target_release}
		else
			echo 'Package: *' | tee -a /etc/apt/preferences.d/${_apt_target_release}
		fi
		echo "Pin: release o=${_apt_target_release}" | tee -a /etc/apt/preferences.d/${_apt_target_release}
		echo 'Pin-Priority: 1000' | tee -a /etc/apt/preferences.d/${_apt_target_release}
	fi
}
### Parse_apt_priority_help parse_apt_priority_help parse_apt_priority.sh
#	File:	${_script_dir}/functions/shared/parse_apt_priority.sh
#	Argument	Variable		Default
#	[-AT=...]	_apt_target		No default, set during run time
#	[-A=...]	_application_list	Set durring run time
#	Notes:	This function is called when mangling sources lists for  apt-get to prevent
#		system from going install crazy.
####
#/etc/apt/preferences.d/
#	echo '' | tee -a /etc/apt/preferences.d/prevent_kernel_upgrades
