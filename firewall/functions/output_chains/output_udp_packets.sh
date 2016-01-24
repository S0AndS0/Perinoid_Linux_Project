Output_udp_packets(){
	echo '## Populating out_udp chain'
	iptables -A out_udp -p UDP --sport 137 -j DROP -m comment --comment "Drop connections to chatty Microsoft devices" || exit 1
	iptables -A out_udp -p UDP --sport 138 -j DROP -m comment --comment "Drop connections to chatty Microsoft devices" || exit 1
	for _dns_addr in ${_dns_addresses:-$(cat /etc/resolv.conf | grep -vE '#' | awk '/nameserver/{print $2}')}; do
		for _dns_port in ${_dns_ports//,/ }; do
			iptables -A out_udp -p UDP -o ${_lo_iface} -d ${_lo_ipv4} -s ${_dns_addr} --sport ${_dns_port} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow loopback to make DNS quaries" || exit 1
			iptables -A out_udp -p UDP -o ${_server_iface} -d ${_server_ipv4} -s ${_dns_addr} --sport ${_dns_port} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow server interface to make DNS requests" || exit 1
		done
	done
	iptables -A out_udp -p UDP -o ${_lo_iface} --sport 123 -j ACCEPT -m comment --comment "Allow loopback interface to make NTP requests" || exit 1
	iptables -A out_udp -p UDP -o ${_server_iface} --sport 123 ACCEPT -m comment --comment "Allow server interface to make NTP requests" || exit 1
	iptables -A out_udp -j RETURN -m comment --comment "Return un-matched packets for further processing." || exit 1
}
