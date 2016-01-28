Torrc_bridge_configs(){
	Arg_checker "${@:---help='Torrc_bridge_configs' --exit='# [Torrc_bridge_configs] # Failed to be read aguments'}" -ep='Torrc_bridge_configs'
	_tor_dir="${_tor_directory:-/etc}/tor"
	_tor_node_name="${_tor_bridge_nickname:-bridge}"
	Overwrite_config_checker "${_tor_directory}/tor/torrc-${_tor_node_name}"
	echo "## Attention [Torrc_bridge_configs] function writing general configuration lines to [${_tor_dir}/torrc-bridge] file"
	echo "User ${_tor_user}" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo 'RunAsDaemon 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo "DataDirectory /var/lib/tor_${_tor_node_name}" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo "PidFile /var/run/tor_${_tor_node_name}.pid" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo 'AvoidDiskWrites 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo 'BridgeRelay 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo "RelayBandwidthRate 100 Kbytes" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo "RelayBandwidthBurst 200 Kbytes" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo "BandwidthRate 300 Kbytes" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo "BandwidthBurst 350 Kbytes" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo 'AccountingStart month 1 00:00' | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo "AccountingMax 80 GB" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo "ORPort ${_tor_or_port:-8443}" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo 'ClientOnly 0' | sudo tee -a ${_torrc_dir}/torrc-${_tor_node_name}
	echo 'ExcludeSingleHopRelays 1' | sudo tee -a ${_torrc_dir}/torrc-${_tor_node_name}
	echo 'Exitpolicy reject *:*' | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo "## Only uncomment next line if geoip support is confermed" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo "#GeoIPFile ${_tor_dir}/geoip" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
	echo "## Notice [Torrc_bridge_configs] function writing spicific configuration lines to [${_tor_dir}/torrc-bridge] file"
	echo "#	based on arguments passed via [-T] and [-B] and [-vf] arguments."
	for _node_type in ${_bridge_type//,/ }; do
		case $_node_type in
			private)
				echo 'PublishServerDescriptor 0' | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo "Address ${_nat_ipv4}" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo "ORListenAddress ${_nat_ipv4}:${_tor_or_port:-8443}" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo "VirtualAddrNetwork ${_tor_virtual_addr_network:-10.192.0.0/10}" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo 'AutomapHostsOnResolve 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo "TransPort ${_tor_trans_port:-9040}" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo "TransListenAddress ${_nat_ipv4}" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo "DNSPort ${_tor_dns_port:-9053}" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo "DNSListenAddress ${_nat_ipv4}" | sudo tee -a ${_torrc_dir}/torrc-${_tor_node_name}
			;;
			public)
				echo 'PublishServerDescriptor 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo "Address ${_external_ipv4}" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo "OutboundBindAddress ${_external_ipv4}" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo "ORListenAddress ${_external_ipv4}:${_tor_or_port:-8443}" | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo 'SocksPort 0' | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				
			;;
			authoritative)
				echo 'AuthoritativeDirectory 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
				echo 'BridgeAuthoritativeDir 1' | sudo tee -a ${_tor_dir}/torrc-${_tor_node_name}
			;;
		esac
	done
#	echo '' | sudo tee -a ${_torrc_dir}/torrc-${_tor_node_name}
#	echo "" | sudo tee -a ${_torrc_dir}/torrc-${_tor_node_name}
}
### Torrc_bridge_configs_help torrc_bridge_configs_help torrc_bridge_configs.sh
#	File:	${_script_dir}/functions/tor/torrc_writers/torrc_bridge_configs.sh
#	Internal variable [\${_tor_dir}] set by [-D=...] argument passed to [${_script_name}]
#	Internal variable [\${_tor_node_name}] set by [-B=...] argument passed to [${_script_name}]
####
#	First argument is inherited from [-D] argument passed to install_tor.sh script and passed
#	from [Write_torrc_configs] function's second argument.
#	Second argument is inherited from [-U] argument passed to install_tor.sh script and passed
#	from [Write_torrc_configs] function's third argument.
#	Third argument is inherited from [-T] argument passed to install_tor.sh script and passed
#	from [Write_torrc_configs] function's forth argument. This is then further processed to
#	subtract words preceading [-] meaning [-T=bridge-privet] is then parced within this function
#	as [privet] instead. Note [-T=bridge-public,privet,authoritative] are acceptable too.
#	Forth argument is inherited from [-B] argument passed to install_tor.sh script and passed
#	from [Write_torrc_configs] function's sevent argument, default [Bridge_Node]
#	Fifth argument is inherited from install_tor.sh script running [Check_host_enviroment] function's
#	internall checks. The first found ip address is matched by default.
#	Sixth argument is inherited from [-ip] argument passed to install_tor.sh script and passed
#	from [Write_torrc_configs] function's eighth argument. Note this last value, your system's
#	external ipv4 address should not be spoofed when running a bridge or exit either input it
#	via argument, set in [-vf] file or set when propmted during run time

