Output_order(){
	echo '## Populating order_output chain'
	iptables -A order_output -o ${_lo_iface} -j ACCEPT -m comment --comment "Allow loopback interface" || exit 1
	iptables -A order_output -p ALL -j out_bad_ip -m comment --comment "Filter output though out_bad_ip chain" || exit 1
	iptables -A order_output -p UDP -j out_udp -m comment --comment "Filter udp packets though out_udp chain" || exit 1
	iptables -A order_output -p ICMP -j icmp_filter -m comment --comment "Filter icmp packets though out_icmp chain" || exit 1
	if [ "${#_check_ip_set}" != "0" ]; then
		iptables -A order_output -o ${_server_iface} -p TCP -j out_port_scan -m comment --comment "Monitor tcp connections with out_port_scan chain" || exit 1
	fi
	iptables -A order_output -p TCP -j out_tcp -m comment --comment "Filter tcp packets though out_tcp chain" || exit 1
	iptables -A order_output -p ALL -m state --state ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow established and related connections" || exit 1
	if [ "${#_admin_ipv4}" != "0" ]; then
		iptables -A order_output -p ALL -o ${_server_iface} -s ${_admin_ipv4} -j ACCEPT -m comment --comment "Allow server to talk back to admin IP address" || exit 1
		echo '## Note when finished testing either comment above or set to empty'
		echo '#	value to better secure server. IP spoofers could use time-out'
		echo '#	and or lockout differances to derive remote sys-admin IP address.'
		echo '#	If sys-admin is on local NAT only then this will only revial internal'
		echo '#	network address sceem to the observant attackers.'
	else
		echo "Notice ${_script_name} did Not set any output rules for \${_admin_ipv4}"
	fi
	iptables -A order_output -j LOG --log-prefix "Output died: a=RETURN" --log-uid -m comment --comment "Log any un-matched packets" || exit 1
	iptables -A order_output -j RETURN -m comment --comment "Return un-matched packets to have default policies take effect" || exit 1
}
