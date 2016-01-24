Input_udp_packets(){
	echo '## Populating in_udp chain'
	iptables -A in_udp -p UDP --dport 137 -j DROP -m comment --comment "Drop packets from chatty Microsoft devices" || exit 1
	iptables -A in_udp -p UDP --dport 138 -j DROP -m comment --comment "Drop packets from chatty Microsoft devices" || exit 1
	for _dns_addr in ${_dns_addresses:-$(cat /etc/resolv.conf | grep -vE '#' | awk '/nameserver/{print $2}')}; do
		for _dns_port in ${_dns_ports//,/ }; do
			iptables -A in_udp -p UDP -i ${_lo_iface} -s ${_lo_ipv4} -d ${_dns_addr} --dport ${_dns_port} -m state --state ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow only established and related connections to loopback for DNS requests" || exit 1
			iptables -A in_udp -p UDP -i ${_server_iface} -s ${_server_ipv4} -d ${_dns_addr} --dport ${_dns_port} -m state --state ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow only established and related connections to server interface for DNS requests" || exit 1
		done
	done
	## Uncomment to allow others to make NTP requests of your server
	#iptables -A in_udp -p UDP -i ${_server_iface} --dport 123 -m state --state NEW -j ACCEPT -m comment --comment "Allow new NTP requests into server" || exit 1
	iptables -A in_udp -p UDP -i ${_lo_iface} --dport 123 -m state --state ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow only established and related NTP requests into loopback" || exit 1
	iptables -A in_udp -p UDP -i ${_server_iface} --dport 123 -m state --state ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow only established and related NTP requests into server interface" || exit 1
	iptables -A in_udp -j RETURN -m comment --comment "Return un-matched packets for further processing." || exit 1
}
