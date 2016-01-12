Forward_interface_or_ports(){
	if [ "${_enable_forwarding}" = "yes" ] && [ "${#_bridge_external_iface}" != "0" ] && [ "${#_bridge_ipv4_addr}" != "0" ] && [ "${#_bridge_port_pares}" != "0" ]; then
		for _port_pare in ${_bridge_port_pares//,/ }; do
			_bridge_external_port="${_port_pare%:*}"
			_bridge_internal_port="${_port_pare#*:}"
			iptables -t nat -A PREROUTING -p tcp --dport ${_bridge_external_port} -j DNAT --to ${_bridge_ipv4_addr%/*}:${_bridge_internal_port} || exit 1
			echo "Notice IP address ${_bridge_ipv4_addr} on bridge ${_bridge_internal_iface} will recieve TCP packets on ${_bridge_internal_port}"
			echo "originally destened for port ${_bridge_external_port} on interface ${_bridge_external_iface}"
			if [ "${#_bridge_internal_iface}" != "0" ]; then
				iptables -A FORWARD -p TCP -m tcp -i ${_bridge_external_iface} -o ${_bridge_internal_iface} --dport ${_bridge_external_port} -j ACCEPT || exit 1
			else
				iptables -A FORWARD -p TCP -m tcp -i ${_bridge_external_iface} -s ${_bridge_ipv4_addr%/*} --sport ${_bridge_internal_port} --dport ${_bridge_external_port} -j ACCEPT || exit 1
			fi
			if [ "${#_bridge_internal_iface}" = "0" ]; then
				iptables -A FORWARD -p TCP -m tcp -o ${_bridge_external_iface} -d ${_bridge_ipv4_addr%/*} --dport ${_bridge_internal_port} --sport ${_bridge_external_port} -j ACCEPT || exit 1
			fi
		done
		if [ "${#_bridge_internal_iface}" != "0" ]; then
			iptables -A FORWARD -i ${_bridge_external_iface} -o ${_bridge_internal_iface} -m state --state RELATED,ESTABLISHED -j ACCEPT || exit 1
			iptables -A FORWARD -i ${_bridge_internal_iface} -j ACCEPT || exit 1
		fi
		iptables -t nat -A POSTROUTING -o ${_bridge_external_iface} -j MASQUERADE || exit 1
		## Dissable or add other bridge forwarding above this line and re-run to add more
		iptables -A FORWARD -j RETURN || exit 1
	fi
}
