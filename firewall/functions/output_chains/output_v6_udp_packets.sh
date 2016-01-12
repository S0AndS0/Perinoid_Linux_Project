Output_v6_udp_packets(){
	if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
		echo '## Populating out_udp_v6 chain'
		ip6tables -A out_udp_v6 -p UDP --sport 137 -j DROP || exit 1
		ip6tables -A out_udp_v6 -p UDP --sport 138 -j DROP || exit 1
		ip6tables -A out_udp_v6 -p UDP -o ${_lo_iface} -d ${_lo_ipv6} --sport ${_dns_port} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT || exit 1
		ip6tables -A out_udp_v6 -p UDP -o ${_server_iface} -d ${_server_ipv6} --sport ${_dns_port} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT || exit 1
		ip6tables -A out_udp_v6 -j RETURN || exit 1
	fi
}
