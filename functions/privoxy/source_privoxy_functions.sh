Source_privoxy_functions(){
	_dir="${1:-$_script_dir}/functions"
	source "${_dir}/privoxy/config_privoxy/privoxy_client_configs.sh"
	source "${_dir}/privoxy/init_scripts/privoxy_init_client.sh"
	source "${_dir}/privoxy/lib_activations/activate_privoxy_configs.sh"
	source "${_dir}/privoxy/installers/aptget_privoxy_install.sh"
##	source "${_dir}/privoxy/installers/source_privoxy_install.sh"
	source "${_dir}/privoxy/lib_activations/activate_privoxy_configs.sh"
	source "${_dir}/privoxy/extras/add_privoxy_user.sh"
#	source "${_dir}/"
}
### Source_privoxy_functions_help source_privoxy_functions_help source_privoxy_functions.sh
#	File:	${_script_dir}/functions/privoxy/source_privoxy_functions.sh
#	runs [source] command to load privoxy related functions into [${_script_name}] run-time.
#	This function is one of the first called when [${_script_name}] detects
#	[-T="client"] as one of the options passed.
####

