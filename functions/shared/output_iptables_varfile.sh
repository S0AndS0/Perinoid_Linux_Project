Output_iptables_varfile(){

## TO-DO : Add the following variable assignments based on installation/configuration
## options chosen.
#	_tcp_ports=""
#	_dns_ports=""
#	_dns_addresses=""
#	_make_bridge_forwarding=""
#	_bridge_internal_iface=""
#	_bridge_port_pares=""
#	_enable_forwarding=""
#	_ssh_port=""
#	_http_port=""
#	_ssl_port=""

	Arg_checker "${@:---help='Output_iptables_varfile' --exit='# [Output_iptables_varfile] # Failed to be read arguments'}" -ep='Output_iptables_varfile'
	_vars_out_file="${_script_dir}/iptables/vars/user_configs.sh"
	Overwrite_config_checker "${_vars_out_file}"
	for _application_name in ${_application_list//,/ }; do
		case ${_application_name} in
			bind|bind9)
				#_bind9_ipv4
				if [ "${_bind9_port}" != "0" ]; then
					_tcp_ports="${_bind9_port},${_tcp_ports}"
				fi
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
				if [ "${#_nginx_http_port}" != "0" ]; then
					_tcp_ports="${_nginx_http_port},${_tcp_ports}"
				fi
				if [ "${#_nginx_ssl_port}" != "0" ]; then
					_tcp_ports="${_nginx_ssl_port},${_tcp_ports}"
				fi
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
							if [ "${#_tor_or_port}" != "0" ]; then
								_tcp_ports="${_tor_or_port},${_tcp_ports}"
							fi
						;;
						bridge)
							for _bridge_type in ${_bridge_types//,/ }; do
								case $_bridge_type in
									privet)
										if [ "${#_tor_dns_port}" != "0" ]; then
											_tcp_ports="${_tor_dns_port},${_tcp_ports}"
										fi
									;;
									public)
										if [ "${#_tor_dir_port}" != "0" ]; then
											_tcp_ports="${_tor_dir_port},${_tcp_ports}"
										fi
										if [ "${#_tor_web_port}" != "0" ]; then
											_tcp_ports="${_tor_web_port},${_tcp_ports}"
										fi
									;;
								esac
							done
						;;
						client)
							#_bridge_ipv4_to_add
							#_bridge_ipv6_to_add
							#_bridge_port_to_add
							if [ "${#_openssh_port}" != "0" ]; then
								_tcp_ports="${_openssh_port},${_tcp_ports}"
							fi
							if [ "${#_tor_dns_port}" != "0" ]; then
								_tcp_ports="${_tor_dns_port},${_tcp_ports}"
							fi
							if [ "${#_tor_ssh_port}" != "0" ]; then
								_tcp_ports="${_tor_ssh_port},${_tcp_ports}"
							fi
							#_tor_socks_bind_address
							#_tor_socks_listen_address
						;;
						exit)
							if [ "${#_tor_dir_port}" != "0" ]; then
								_tcp_ports="${_tor_dir_port},${_tcp_ports}"
							fi
							if [ "${#_tor_web_port}" != "0" ]; then
								_tcp_ports="${_tor_web_port},${_tcp_ports}"
							fi
						;;
						relay)
							#_tor_relay_bandwidth_rate
							#_tor_relay_bandwidth_burst
							if [ "${#_tor_dir_port}" != "0" ]; then
								_tcp_ports="${_tor_dir_port},${_tcp_ports}"
							fi
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
	
	

	# _incoming_tcp_update_seconds="60"
	# _incoming_tcp_hitcount="8"
	# _incoming_tcp_update_seconds="300"
	# _incoming_tcp_burst_minute="25"
	# _incoming_tcp_burst_limit="100"
	# _outgoing_tcp_update_seconds="60"
	# _outgoing_tcp_hitcount="8"
	# _outgoing_tcp_update_seconds="300"
	# _outgoing_tcp_burst_minute="25"
	# _outgoing_tcp_burst_limit="100"

}
### Output_iptables_varfile_help output_iptables_varfile_help output_iptables_varfile.sh
#	File : ${_script_dir}/functions/shared/output_iptables_varfile.sh
#	Argument		Variable					Usage
#	-B9ipv4			_bind9_ipv4					Sets IP address that Bind9 services will bind to
#	-B9P			_bind9_port					Sets port that Bind9 services will bind to
#	-FBI			_firejail_bridge_interface	Sets interface name that Firejail will bind to
#	-FBF			_firejail_bridge_forward	Sets wheather or not to forward connections into firejail'ed network
#	-FHI			_firejail_host_interface	Sets hosts interface name that packets will be forwarded through
#	-FBipv4			_firejail_bridge_ipv4		Sets
#	-FNipv4			_firejail_nat_ipv4			Sets 
#	-NHP			_nginx_http_port			Sets port that Nginx will bind to for http traffic
#	-NSP			_nginx_ssl_port				Sets port that Nginx will bind to for ssl traffic
#	-TOP			_tor_or_port				Sets
#	-TDNSP			_tor_dns_port				Sets
#	-TDP			_tor_dir_port				Sets 
#	-TWP			_tor_web_port				Sets
#	-ABipv4			_bridge_ipv4_to_add			Sets
#	-ABipv6			_bridge_ipv6_to_add			Sets
#					_bridge_port_to_add			Sets
#	-OSP			_openssh_port				Sets
#	-TSP			_tor_ssh_port				Sets
#	-TSBA			_tor_socks_bind_address		Sets
#	-TSLA			_tor_socks_listen_address	Sets
#					_tor_relay_bandwidth_rate	Sets
#					_tor_relay_bandwidth_burst	Sets
#					_external_ipv4				Sets
#					_external_ipv6				Sets
#					_enable_ipv6				Sets
#					_admin_ipv4					Sets
#					_admin_ipv6					Sets
#					_nat_ipv4					Sets
#					_nat_ipv6					Sets
####

