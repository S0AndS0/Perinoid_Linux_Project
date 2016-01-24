Output_variables_file(){
	Arg_checker "${@:---help='Output_variables_file' --exit='# [Output_variables_file] # Failed to be read arguments'}" -ep='Output_variables_file'
	_vars_out_file="${_script_dir}/variables/${USER}_vars.sh"
	Overwrite_config_checker "${_vars_out_file}"
	echo "## Attention [Output_variables_file] function writing out variables file to [${_vars_out_file}]"
	echo "_application_list=\"${_application_list}\"" | tee -a ${_vars_out_file}
	echo "_connection_count=\"${_connection_count}\"" | tee -a ${_vars_out_file}
	echo "_enable_ipv6=\"${_enable_ipv6}\"" | tee -a ${_vars_out_file}
	echo "_external_ipv4=\"${_external_ipv4}\"" | tee -a ${_vars_out_file}
	echo "_external_ipv6=\"${_external_ipv6}\"" | tee -a ${_vars_out_file}
	echo "_install_method=\"${_install_method}\"" | tee -a ${_vars_out_file}
	echo "_nat_ipv4=\"${_nat_ipv4}\"" | tee -a ${_vars_out_file}
	echo "_nat_ipv6=\"${_nat_ipv6}\"" | tee -a ${_vars_out_file}
	echo "_temp_dir=\"${_temp_dir}\"" | tee -a ${_vars_out_file}
	for _apps in ${_application_list//,/ }; do
		case ${_apps} in
			nginx|all)
				echo "_nginx_dir=\"${_nginx_dir}\"" | tee -a ${_vars_out_file}
				echo "_nginx_index=\"${_nginx_index}\"" | tee -a ${_vars_out_file}
				echo "_nginx_http_port=\"${_nginx_http_port}\"" | tee -a ${_vars_out_file}
				echo "_nginx_ssl_port=\"${_nginx_ssl_port:-8443}\""| tee -a ${_vars_out_file}
				echo "_nginx_service_name=\"${_nginx_service_name}\"" | tee -a ${_vars_out_file}
				echo "_nginx_url=\"${_nginx_url}\"" | tee -a ${_vars_out_file}
			;;
			tor|all)
				echo "_bridge_ipv4_to_add=\"${_bridge_ipv4_to_add}\"" | tee -a ${_vars_out_file}
				echo "_bridge_ipv6_to_add=\"${_bridge_ipv6_to_add}\"" | tee -a ${_vars_out_file}
				echo "_bridge_finger_print_to_add=\"${_bridge_finger_print_to_add}\"" | tee -a ${_vars_out_file}
				echo "_bridge_type_to_add=\"${_bridge_type_to_add}\"" | tee -a ${_vars_out_file}
				echo "_bridge_port_to_add=\"${_bridge_port_to_add}\"" | tee -a ${_vars_out_file}
				echo "_btc_address=\"${_btc_address}\"" | tee -a ${_vars_out_file}
				echo "_email_address=\"${_email_address}\"" | tee -a ${_vars_out_file}
				echo "_hidden_auth_cookie=\"${_hidden_auth_cookie}\"" | tee -a ${_vars_out_file}
				echo "_tor_dir_port="${_tor_dir_port}\"" | tee -a ${_vars_out_file}
				echo "_tor_dns_port="${_tor_dns_port}\"" | tee -a ${_vars_out_file}
				echo "_tor_directory=\"${_tor_directory}\"" | tee -a ${_vars_out_file}
				echo "_tor_node_types=\"${_tor_node_type}\"" | tee -a ${_vars_out_file}
				echo "_tor_bridge_nickname=\"${_tor_bridge_nickname}\"" | tee -a ${_vars_out_file}
				echo "_tor_exit_nickname=\"${_tor_exit_nickname}\"" | tee -a ${_vars_out_file}
				echo "_tor_relay_nickname=\"${_tor_relay_nickname}\"" | tee -a ${_vars_out_file}
#				echo "_tor_service_nickname=\"${_tor_service_nickname}\"" | tee -a ${_vars_out_file}
				echo "_tor_relay_bandwidth_rate=\"${_tor_relay_bandwidth_rate}\"" | tee -a ${_vars_out_file}
				echo "_tor_relay_bandwidth_burst=\"${_tor_relay_bandwidth_burst}\"" | tee -a ${_vars_out_file}
				echo "_tor_user=\"${_tor_user}\"" | tee -a ${_vars_out_file}
				echo "_tor_service_clients=\"${_tor_service_clients}\"" | tee -a ${_vars_out_file}
				echo "_tor_or_port=\"${_tor_or_port}\"" | tee -a ${_vars_out_file}
				echo "_tor_ssh_port=\"${_tor_ssh_port}\"" | tee -a ${_vars_out_file}
				echo "_tor_socks_bind_address=\"${_tor_socks_bind_address}\"" | tee -a ${_vars_out_file}
				echo "_tor_socks_listen_address=\"${_tor_socks_listen_address}\"" | tee -a ${_vars_out_file}
				echo "_tor_web_port=\"${_tor_web_port}\"" | tee -a ${_vars_out_file}
				echo "_tor_web_dir=\"${_tor_web_dir}\"" | tee -a ${_vars_out_file}
				echo "_bridge_types=\"${_bridge_types}\"" | tee -a ${_vars_out_file}
				echo "_client_types=\"${_client_types}\"" | tee -a ${_vars_out_file}
				echo "_exit_types=\"${_exit_types}\"" | tee -a ${_vars_out_file}
				echo "_relay_types=\"${_relay_types}\"" | tee -a ${_vars_out_file}
				echo "_service_types=\"${_service_types}\"" | tee -a ${_vars_out_file}
				echo "_open_services=\"${_open_services}\"" | tee -a ${_vars_out_file}
				echo "_auth_services=\"${_auth_services}\"" | tee -a ${_vars_out_file}
			;;
			privoxy|all)
				echo "_privoxy_dir=\"${_privoxy_dir}\"" | tee -a ${_vars_out_file}
				echo "_privoxy_user=\"${_privoxy_user}\"" | tee -a ${_vars_out_file}
			;;
			polipo|all)
				echo "_polipo_dir=\"${_polipo_dir}\"" | tee -a ${_vars_out_file}
				echo "_polipo_user=\"${_polipo_user}\"" | tee -a ${_vars_out_file}
			;;
			squid|squid3|all)
				echo "_squid_dir="${_squid_dir}\"" | tee -a ${_vars_out_file}
				echo "_squid_user="${_squid_dir}\"" | tee -a ${_vars_out_file}
			;;
			bind|bind9|all)
				echo "_bind9_dir=\"${_bind9_dir:-/etc}\"" | tee -a ${_vars_out_file}
				echo "_bind9_user=\"${_bind9_user:-named}\"" | tee -a ${_vars_out_file}
				echo "_bind9_ipv4=\"${_bind9_ipv4:-127.0.0.1}\"" | tee -a ${_vars_out_file}
				echo "_bind9_port=\"${_bind9_port:-53}\"" | tee -a ${_vars_out_file}
			;;
			firejail|all)
				echo "_firejail_bridge_interface=\"${_firejail_bridge_interface}\""
				echo "_firejail_bridge_ipv4=\"${_firejail_bridge_ipv4}\""
				echo "_firejail_bridge_forward=\"${_firejail_bridge_forward}\""
				echo "_firejail_dir=\"${_firejail_dir}\""
				echo "_firejail_host_interface=\"${_firejail_host_interface}\""
				echo "_firejail_nat_ipv4=\"${_firejail_nat_ipv4}\""
				echo "_firejail_service_name=\"${_firejail_service_name}\""

			;;
			firetools|all)
				
			;;
		esac
	done
#	echo "_external_parse=\"${_external_parse}\"" | tee -a ${_vars_out_file}
	echo "_openssh_port=\"${_openssh_port}\"" | tee -a ${_vars_out_file}
	echo "_ssh_host_name=\"${_ssh_host_name}\"" | tee -a ${_vars_out_file}
	echo "_ssh_host_domain=\"${_ssh_host_domain}\"" | tee -a ${_vars_out_file}

}
### Output_variables_file_help output_variables_file_help output_variables_file.sh
#	This function re-reads variables through [] function and outputs custom variables file
#	for ${USER} these files maybe loaded latter to repeat the same configurations without
#	specifying anything more than [-vf="${_vars_out_file}"]
#	The files written by this function are saved under [${_script_dir}/variables/]
#	directory
####
#_passwd="${_passwd:-12}"

