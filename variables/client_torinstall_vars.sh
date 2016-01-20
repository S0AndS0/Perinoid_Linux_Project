#_bridge_ipv4_to_add=""
#_bridge_ipv6_to_add=""
#_bridge_finger_print_to_add=""
#_bridge_type_to_add=""
#_bridge_port_to_add=""
_application_list="tor,privoxy,squid,bind"
_connection_count="8"
_enable_ipv6="no"
#_external_ipv4=""
#_external_ipv6=""
_install_method="safe"
#_nat_ipv4=""
#_nat_ipv6=""
_temp_dir="/tmp"
_tor_user="debian-tor"
_tor_directory="/etc"
_tor_dns_port="5300"
_tor_node_type="client"
### client_torinstall_vars_help client_torinstall_vars.sh
#	File:	${_script_dir}/functions/tor/sample_vars/client_torinstall_vars.sh
#	See [${_script_name} -h='blank_torinstall_vars'] and
#	See [${_script_name} -h='Arg_checker_tor'] for what these
#		variables and arguments are used for and how to properly
#		set them. This file maybe "safely" used to isntall tor
#		node type [client] only by running the follwoing
#		[ ${_script_name} -vf="${_script_dir}/functions/tor/sample_vars/client_torinstall_vars.sh" ]
#		as a sudo level user, but not as [root] or errors will be
#		presented before exiting with error syatus [1]
####

