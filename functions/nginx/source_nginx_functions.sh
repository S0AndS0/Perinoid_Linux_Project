Source_nginx_functions(){
	_dir="${1:-$_script_dir}/functions"
	source "${_dir}/nginx/installers/source_nginx_install.sh"
	source "${_dir}/nginx/installers/aptget_nginx_install.sh"
	source "${_dir}/nginx/extras/password_append_configs.sh"
	source "${_dir}/nginx/extras/ssl_append_configs.sh"
	source "${_dir}/nginx/config_nginx/write_nginx_server_block.sh"
	source "${_dir}/nginx/config_nginx/write_nginx_server_config.sh"
	source "${_dir}/nginx/init_scripts/write_nginx_init.sh"
#	source "${_dir}/nginx/"
}
### Source_nginx_functions_help source_nginx_functions_help source_nginx_functions.sh
#	File:	${_script_dir}/functions/nginx/source_nginx_functions.sh
####

