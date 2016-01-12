Source_polipo_functions(){
	_dir="${1:-$_script_dir}/functions"
	source "${_dir}/polipo/order_polipo_install.sh"
	source "${_dir}/polipo/installers/aptget_polipo_install.sh"
	source "${_dir}/polipo/installers/source_polipo_install.sh"
	source "${_dir}/polipo/extras/add_polipo_user.sh"
	source "${_dir}/polipo/polipo_configs/append_polipo_config.sh"
	source "${_dir}/polipo/init_scripts/polipo_init_client.sh"
#	source ${_dir}/polipo/extras
#	source ${_dir}/polipo/polipo_configs
}
### Source_polipo_functions_help source_polipo_functions_help source_polipo_functions.sh
#	File:	${_script_dir}/functions/polipo/source_polipo_functions.sh
####
