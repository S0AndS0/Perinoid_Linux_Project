Source_squid_functions(){
	_dir="${1:-$_script_dir}/functions"
	source "${_dir}/squid/squid_configs/append_squid_configs.sh"
	source "${_dir}/squid/squid_configs/write_squid_in_conf.sh"
	source "${_dir}/squid/squid_configs/write_squid_out_conf.sh"
	source "${_dir}/squid/extras/refresh_squid_configs.sh"
#	source "${_dir}/squid/"
}
### Source_squid_functions_help source_squid_functions_help source_squid_functions.sh
#	File:	${_Script_dir}/functions/squid/source_squid_functions.sh
#	Argument	Variable		Default
#	\$1		_dir			${_script_dir:-/etc}/functions
####
