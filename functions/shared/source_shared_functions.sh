Source_shared_functions(){
	_dir="${1:-$_script_dir}/functions"
	source "${_dir}/shared/arg_checker.sh"
	source "${_dir}/shared/check_host_enviroment.sh"
	source "${_dir}/shared/error_generator.sh"
	source "${_dir}/shared/fix_android_inet.sh"
	source "${_dir}/shared/fix_apt_keys.sh"
	source "${_dir}/shared/install_apt.sh"
	source "${_dir}/shared/make_random_passwd.sh"
	source "${_dir}/shared/output_iptables_varfile.sh
	source "${_dir}/shared/output_variables_file.sh"
	source "${_dir}/shared/overwrite_config_checker.sh"
	source "${_dir}/shared/overwrite_init_checker.sh"
	source "${_dir}/shared/parse_apt_autoclean.sh"
	source "${_dir}/shared/parse_apt_priority.sh"
	source "${_dir}/shared/parse_help.sh"
	source "${_dir}/shared/parse_varfile_load.sh"
	source "${_dir}/shared/source_functions.sh"
	source "${_dir}/shared/start_service.sh"
#	source "${_dir}/shared/"
}
### Source_shared_functions_help source_shared_functions_help source_shared_functions.sh
#	File:	${_script_dir}/functions/shared/source_shared_functions.sh
#	Usage:	This function serves the perpious of sourcing functions from this directory
#		and also providing a file for [Parse_help] function to parse for further help
#		help docuemtnation.
####
