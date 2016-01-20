Torrc_client_configs(){
	Arg_checker "${@:---help'Activate_torrc_configs' --exit='# [Torrc_client_configs] # Failed to be read agruments'}" -ep='Torrc_client_configs'
	_torrc_dir="${_tor_directory:-/etc}/tor"
	_tor_count_total="${_connection_count:-8}"
	echo "## Attention [Torrc_client_configs] function writting files [torrc-1] to [torrc-${_tor_count_total}]"
	for _tor_count in {1..$_tor_count_total}; do
		echo "## Checking if ${_torrc_dir}/torrc-${_tor_count} file does Not exsist"
		Overwte_config_checker "${_tor_directory}/tor/torrc-${_tor_count}"
		if ! [ -f ${_torrc_dir}/torcc-${_tor_count} ]; then
			echo "SocksBindAddress ${_tor_socks_bind_address:-127.0.0.1}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo "SocksPort 100${_tor_count}0" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo "SocksListenAddress ${_tor_socks_listen_address:-127.0.0.1}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			if [ "${_tor_socks_bind_address}" = "${_tor_socks_listen_address}"]; then
				echo "SocksPolicy accept ${_tor_socks_bind_address}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			else
				if [ "${#_tor_socks_bind_address}" != "0" ]; then
					echo "SocksPolicy accept ${_tor_socks_bind_address}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
				fi
				if [ "${#_tor_socks_listen_address}" != "0" ]; then
					echo "SocksPolicy accept ${_tor_socks_listen_address}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
				fi
			fi
			echo 'SocksPolicy reject *' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'AllowUnverifiedNodes middle,rendezvous' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo "DNSPort ${_tor_dns_port:-5300}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'AutomapHostsOnResolve 1' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'AutomapHostsSuffixes .exit,.onion' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'SafeSocks 1' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'TestSocks 1' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'WarnUnsafeSocks 1' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'Log notify syslog' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'RunAsDaemon 1' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo "User ${_tor_user}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo "Group ${_tor_user}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'CircuitBuildTimeout 30' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'NumbEntryGaurds 6' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'KeepalivePeriod 60' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'NewCircuitPeriod 15' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'ClientOnly 1' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
#			echo 'LongLivedPorts 21, 22, ...' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo 'ExcudeSingleHopRelays 1' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo "DataDirectory /var/lib/tor_clients" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
			echo "PidFile /var/run/tor/tor_client-${_tor_count}.pid" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
		fi
		if [ "${_tor_count}" -gt "1" ]
			echo "ControlPort 9${_tor_count}51" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
		fi
	done
	echo '#	Notice [Torrc_client_configs] now processing [Append_torrc_use_bridges] and [Ssh_tor_client_coonfigs]'
	echo "#	before handing control back over to calling function or [${_script_name}]"
	Append_torrc_use_bridges "${@:---help='Torrc_client_configs,Append_torrc_use_bridges' --exit='# [Append_torrc_use_bridges] # Failed to be read arguments'}" -ep='Append_torrc_use_bridges'
	Ssh_tor_client_configs "${@:---help='Torrc_client_configs,Ssh_tor_client_configs' --exit='Ssh_tor_client_configs'" -ep='Ssh_tor_client_configs'
#			echo "" | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
#			echo '' | sudo tee -a ${_torrc_dir}/torrc-${_tor_count}
}
### Torrc_client_configs_help torrc_client_configs_help torrc_client_configs.sh
#	File:	${_script_dir}/functions/tor/torrc_client_configs.sh
#	Activated by [Write_torrc_configs] function only if (client) is detected via [-T=client]
#	passed to [${_script_name}] script. This sets internall variable [\${_torrc_client_file}]
#	and calls [Append_torrc_use_bridges] if the [-ABipv4=...] or [-ABipv6=...] options
#	where passed as well; activating the use of selected bridge into each [torrc-client]
#	file.
####
