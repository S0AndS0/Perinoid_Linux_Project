Source_firejail_functions(){
	_dir="#{1:-$_script_dir}/functions"
	source "${_dir}/firejail/order_firejail_install.sh"
#	source "${_dir}/firejail/extras"
	source "${_dir}/firejail/extras/firejail_setup_jailed_network.sh"
	source "${_dir}/firejail/extras/firejail_signin_privet.sh"
	source "${_dir}/firejail/installers/aptget_firejail_install.sh"
	source "${_dir}/firejail/installers/source_firejail_install.sh"
#	source "${_dir}/firejail/firejail_configs"
#	source "${_dir}/firejail/"
}
### Source_firejail_functions_help source_firejail_functions_help source_firejail_functions.sh
#	File:	${_script_dir}/functions/firejail/source_firejail_functions.sh
#	Argument	Variable		Default
#	\$1		_dir			${_script_dir}
#	Notes:	This function serves to load firejail related functions into [${_script_name}] run time
#		as well as act as a list of files to search for help documentation via [-h='function_name']
#		option.
####
