Output_firewall_configs(){
	Arg_checker "${@:---help='Output_firewall_configs' --exit='# [Output_firewall_configs] # Failed to be read arguments'}" -ep='Output_firewall_configs'
	_vars_out_file="${_script_dir}/firewall/vars/user_configs.sh"
	Overwrite_config_checker "${_vars_out_file}"
	for _apps in ${_application_list//,/ }; do
		case ${_apps} in
			nginx)
				
			;;
			tor)
				
			;;
			privoxy)
				
			;;
			polipo)
				
			;;
			squid|squid3)
				
			;;
			bind|bind9)
				
			;;
			firejail)
				
			;;
			firetools)
				
			;;
			NULL|null)
				
			;;
			ALL)
				
			;;
		esac
	done
	echo "## Attention [Output_firewall_configs] function writing out variables file to [${_vars_out_file}]"
	echo "export _admin_ipv4=\"\"" | tee -a ${_vars_out_file}
	echo "export _admin_ipv6=\"\"" | tee -a ${_vars_out_file}
	echo "export _external_ipv4=\"${_external_ipv4}\"" | tee -a ${_vars_out_file}
	echo "export _http_port=\"80\"" | tee -a ${_vars_out_file}
	echo "export _ssl_port=\"443\"" | tee -a ${_vars_out_file}
	echo "export _dns_ports=\"53,${_tor_dns_port}\"" | tee -a ${_vars_out_file}
	echo "export _ssh_port=\"22\"" | tee -a ${_vars_out_file}
	echo "export _make_bridge_forwarding=\"yes\"" | tee -a ${_vars_out_file}
	echo "export _bridge_internal_iface=\"${_firejail_bridge_interface}\"" | tee -a ${_vars_out_file}
	echo "export _bridge_port_pares=\"\${_http_port}:${_nginx_http_port},\${_ssl_port}:${_nginx_ssl_port:-8443}\"" | tee -a ${_vars_out_file}
	echo "export _enable_forwarding=\"no\"" | tee -a ${_vars_out_file}
	echo "export _policy_forward=\"ACCEPT\"" | tee -a ${_vars_out_file}
	echo "export _policy_input=\"ACCEPT\"" | tee -a ${_vars_out_file}
	echo "export _policy_output=\"ACCEPT\"" | tee -a ${_vars_out_file}
	echo "export _incoming_tcp_update_seconds=\"60\"" | tee -a ${_vars_out_file}
	echo "export _incoming_tcp_hitcount=\"8\"" | tee -a ${_vars_out_file}
	echo "export _incoming_tcp_update_seconds=\"300\"" | tee -a ${_vars_out_file}
	echo "export _incoming_tcp_burst_minute=\"25\"" | tee -a ${_vars_out_file}
	echo "export _incoming_tcp_burst_limit=\"100\"" | tee -a ${_vars_out_file}
	echo "export _outgoing_tcp_update_seconds=\"60\"" | tee -a ${_vars_out_file}
	echo "export _outgoing_tcp_hitcount=\"8\"" | tee -a ${_vars_out_file}
	echo "export _outgoing_tcp_update_seconds=\"300\"" | tee -a ${_vars_out_file}
	echo "export _outgoing_tcp_burst_minute=\"25\"" | tee -a ${_vars_out_file}
	echo "export _outgoing_tcp_burst_limit=\"100\"" | tee -a ${_vars_out_file}
}
### Output_firewall_configs_help output_firewall_configs_help output_firewall_configs.sh
#	File ${_script_dir}/functions/shared/output_firewall_configs.sh
#	
####
