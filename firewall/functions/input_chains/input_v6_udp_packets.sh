Input_v6_udp_packets(){
	if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
		echo '## Populating in_udp_v6 chain'
		ip6tables -A in_udp_v6 -p UDP --dport 137 -j DROP -m comment --comment "Drop connections from chatty Microsoft devices" || exit 1
		ip6tables -A in_udp_v6 -p UDP --dport 138 -j DROP -m comment --comment "Drop connections from chatty Microsoft devices" || exit 1
		ip6tables -A in_udp_v6 -p UDP -i ${_lo_iface} -s ${_lo_ipv6} --dport ${_dns_port} -m state --state ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Accept established and related connections to ${_lo_iface} to ${_dns_port}" || exit 1
		ip6tables -A in_udp_v6 -p UDP -i ${_server_iface} -s ${_server_ipv6} --dport ${_dns_port} -m state --state ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Accept established and related connections to ${_server_iface} from ${_dns_port}" || exit 1
		ip6tables -A in_udp_v6 -j RETURN -m comment --comment "Return un-matched packets for further processing." || exit 1
	fi
}
