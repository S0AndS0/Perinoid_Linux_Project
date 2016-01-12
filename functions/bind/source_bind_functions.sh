Source_bind_functions(){
	_dir="${1:-$_script_dir}/functions"
	source "${_dir}/bind/extras/mitigate_dns_poision_iptables.sh"
	source "${_dir}/bind/extras/resolv_conf_bind.sh"
	source "${_dir}/bind/extras/add_bind_user.sh"
	source "${_dir}/bind/installers/aptget_bind_install.sh"
#	source "${_dir}/bind/installers/source_bind_install.sh"
	source "${_dir}/bind/bind_configs/write_bind_named_config.sh"
	source "${_dir}/bind/bind_configs/write_bind_named_empty.sh"
	source "${_dir}/bind/bind_configs/write_bind_tor_logging.sh"
	source "${_dir}/bind/bind_configs/write_bind_tor_options.sh"
	source "${_dir}/bind/bind_configs/write_bind_tor_zones.sh"
	source "${_dir}/bind/bind_configs/write_bind_onion.sh"
#	source "${_dir}/bind/extras"
#	source "${_dir}/bind/bind_configs"
}
### Source_bind_functions_help source_bind_functions_help source_bind_functions.sh
#	File:	${_script_dir}/functions/bind/source_bind_functions.sh
####
