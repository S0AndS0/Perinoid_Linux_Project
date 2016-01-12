Append_torrc_use_bridges(){
	Arg_checker "${@:---help='Append_torrc_usebridges' --exit='# [Append_torrc_usebridges] # Failed'}" -ep='Append_torrc_usebridges'
	for _count in {1..$_connection_count}; do
		_torrc_client_file="${_tor_directory:-/etc}/tor/torrc-${_count}"
		if [ -f ${_torrc_client_file} ]; then
			_search_use_bridges=$(grep -E 'UseBridges 1' ${_torrc_client_file} | grep -vE '#')
			if [ "${#_search_use_bridges}" != "0" ]; then
				echo 'UseBridges 1' | sudo tee -a ${_torrc_client_file}
			fi
			if [ "${#_bridge_ipv4_to_add}" != "0" ]; then
				case ${_bridge_type_to_add} in
					obfs3)
						echo 'ClientTransportPlugin obfs3 exec /usr/bin/obfsproxy managed' | sudo tee -a ${_torrc_client_file}
						_bridge_line="Bridge obfs3 ${_bridge_ipv4_to_add}:${_bridge_port_to_add} ${_bridge_finger_print_to_add}"
					;;
					*)
						_bridge_line="Bridge ${_bridge_ipv4_to_add}:${_bridge_port_to_add} ${_bridge_finger_print_to_add}"
					;;
				esac
				if [ "${#_bridge_line}" != "0" ]; then
					echo "${_bridge_line}" | sudo tee -a ${_torrc_client_file}
				fi
			elif [ "${#_bridge_ipv6_to_add}" != "0" ]; then
				case ${_bridge_type_to_add} in
					obfs3)
						echo 'ClientTransportPlugin obfs3 exec /usr/bin/obfsproxy managed' | sudo tee -a ${_torrc_client_file}
						_bridge_line="Bridge obfs3 [${_bridge_ipv6_to_add}]:${_bridge_port_to_add} ${_bridge_finger_print_to_add}"
					;;
					*)
						_bridge_line="Bridge ${_bridge_ipv6_to_add} ${_bridge_finger_print_to_add}"
					;;
				esac
				if [ "${#_bridge_line}" != "0" ]; then
					echo "${_bridge_line}" | sudo tee -a ${_torrc_client_file}
				fi
			fi
			if [ "${#_bridge_line}" = "0" ]; then
				echo "## Error [Append_torrc_use_bridges] function failed to add [${_bridge_line}] to [${_torrc_client_file}] file"
				echo '#	this is from [${_bridge_line}] variable being blank and should not prevent using tor'
				echo '#	without bridges being enabled, however, you may wish to check the above file manualy'
				echo "#	ei [ sudo nano ${_torrc_client_file} ] and add the bridge desired there"
				echo '#	ei [ Bridge <bridge_ip>:<bridge_port> ]'
				echo '#	or [ Bridge obfs3 <bridge_ip>:<bridge_port> <bridge_finger_print> ]'
				echo "#	Continuing with ${_script_name} normal run-time..."
			fi
		else
			echo "## Error [Append_torrc_usebridges] function failed to add [${_bridge_line}] to [${_torrc_client_file}] file"
			echo '#	the file [${_torrc_client_file}] variable should have been set prior to running this function, usually'
			echo '#	this is done during [Torrc_client_configs] function run-time (near the tail of "for, do, done" loop'
		fi
	done
}
### Append_torrc_use_bridges_help append_torrc_use_bridges_help append_torrc_use_bridges.sh
#	File:	${_script_dir}/functions/tor/extras/append_torrc_use_bridges.sh
#	Argument	Variable		Default
#	[-C=...]	_connection_count	8
#	[-ABipv4=...]	_bridge_ipv4_to_add	
#	[-ABipv6=...]	_bridge_ipv6_to_add	
#	[-ABf=...]	_bridge_finger_print_to_add
#	[-ABt=...]	_bridge_type_to_add	
#	[-ABp=...]	_bridge_port_to_add	
#	[-T=...]	_tor_node_types		client
#	Notes:	Called internally from [Torrc_client_configs] function only if [-ABipv4=...]
#	or if [-ABipv6=...] arguments are detected within [${_script_name}] script.
#	Depending on the number chosen for [-C=...] option this function maybe called multiple
#	times just after the loop that [Torrc_client_configs] function uses. Though positional
#	arguments could suffice it would only push the processing to another function, making
#	this function a bit more difficult to intigrate with [${_script_name}] external
#	calling capibilaties.
####
