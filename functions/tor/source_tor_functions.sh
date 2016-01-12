Source_tor_functions(){
	_dir="${1:-$_script_dir}/functions"
	source "${_dir}/nginx/write_nginx_server_block.sh"
	source "${_dir}/tor/lib_activation/activate_torrc_client.sh"
	source "${_dir}/tor/lib_activation/activate_torrc_nonclient.sh"
	source "${_dir}/tor/torrc_writers/torrc_bridge_configs.sh"
	source "${_dir}/tor/torrc_writers/torrc_client_configs.sh"
	source "${_dir}/tor/torrc_writers/torrc_exit_configs.sh"
	source "${_dir}/tor/torrc_writers/torrc_relay_configs.sh"
	source "${_dir}/tor/torrc_writers/torrc_service_configs.sh"
	source "${_dir}/tor/init_scripts/write_tor_init_client.sh"
	source "${_dir}/tor/init_scripts/write_tor_init_nonclient.sh"
	source "${_dir}/tor/extras/add_tor_user.sh"
	source "${_dir}/tor/extras/append_torrc_use_bridges.sh"
	source "${_dir}/tor/extras/mod_hosts_file.sh"
	source "${_dir}/tor/extras/selinux_tor_mod.sh"
	source "${_dir}/tor/extras/ssh_tor_client_configs.sh"
	source "${_dir}/tor/installers/source_tor_install.sh"
	source "${_dir}/tor/installers/aptget_tor_install.sh"
	source "${_dir}/tor/order_tor_install.sh"
#	source "${_dir}/tor/rcd_scripts/write_tor_client_rcd.sh"
}
### Source_tor_functions_help source_tor_functions_help source_tor_functions.sh
#	File: ${_script_dir}/functions/tor/source_tor_functions.sh
#	Positional Arguments examples
## Source_tor_functions $1
## Source_tor_functions ${_script_dir}/functions
#	Positional Arguments explained
#	This function loads all default functions for [${_script_name}] so long as both
#	[tor] and [shared] sub-directories are found. The sourcing of each function does
#	not do anything by itself, instead sourcing allows varias functions to call
#	one another by name from within [${_script_name}]'s shell.
#	This is the third and finall place that script modders and authors should
#	use to incorperate new features within [${_script_name}] run-time.
#	Prior to this step are using [-vf=...] argument and second option being
#	[Source_functions] found under [${_script_dir}/functions/shared] directory
####
##	source "${_dir}/tor/activate_services/activate_torrc_client.sh"
##	source "${_dir}/tor/activate_services/activate_torrc_nonclient.sh"
##	source "${_dir}/tor/write_tor_init.sh"
##	source "${_dir}/tor/write_torrc_configs.sh"
