Output_iptables_varfile(){

## TO-DO : Add tcp ports to ${_tcp_ports} variable based on application being configured

	Arg_checker "${@:---help='Output_iptables_varfile' --exit='# [Output_iptables_varfile] # Failed to be read arguments'}" -ep='Output_iptables_varfile'
	_vars_out_file="${_script_dir}/iptables/vars/user_configs.sh"
	Overwrite_config_checker "${_vars_out_file}"
	for _application_name in ${_application_list//,/ }; do
		case ${_application_name} in
			bind|bind9)
				#_bind9_ipv4
				#_bind9_port
			;;
			firejail)
				#_firejail_bridge_interface
				#_firejail_bridge_forward
				#_firejail_host_interface
				#_firejail_bridge_ipv4
				#_firejail_nat_ipv4
			;;
			firetools)
				
			;;
			nginx)
				#_nginx_http_port
				#_nginx_ssl_port
			;;
			privoxy)
				
			;;
			polipo)
				
			;;
			squid|squid3)
				
			;;
			tor)
				for _node_types in ${_tor_node_types//,/ }; do
					case $_node_types in
						*)
							#_tor_or_port
						;;
						bridge)
							for _bridge_type in ${_bridge_types//,/ }; do
								case $_bridge_type in
									privet)
										#_tor_dns_port
									;;
									public)
										#_tor_dir_port
										#_tor_web_port
									;;
								esac
							done
						;;
						client)
							#_bridge_ipv4_to_add
							#_bridge_ipv6_to_add
							#_bridge_port_to_add
							#_openssh_port
							#_tor_dns_port
							#_tor_ssh_port
							#_tor_socks_bind_address
							#_tor_socks_listen_address
						;;
						exit)
							#_tor_dir_port
							#_tor_web_port
						;;
						relay)
							#_tor_relay_bandwidth_rate
							#_tor_relay_bandwidth_burst
							#_tor_dir_port
						;;
					esac
				done
			;;
		esac
	done
	
	#_external_ipv4
	#_external_ipv6
	
	#_enable_ipv6
	
	#_admin_ipv4
	#_admin_ipv6
	
	#_nat_ipv4
	#_nat_ipv6
	
	

}
### Output_iptables_varfile_help output_iptables_varfile_help output_iptables_varfile.sh
#	File : ${_script_dir}/functions/shared/output_iptables_varfile.sh
#	
####
