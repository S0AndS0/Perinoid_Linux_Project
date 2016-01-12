Input_order(){
	echo '## Populating input_order chain'
	iptables -A order_input -p ALL -i ${_lo_iface} -s ${_lo_ipv4} -j ACCEPT -m comment --comment "Accept loopback traffic" || exit 1
	iptables -A order_input -p ALL -j in_bad_ip -m comment --comment "Check for spoofed and bad addresses" || exit 1
	iptables -A order_input -p ALL -j in_bad_packets -m comment --comment "Check for ban and invalid packets" || exit 1
	iptables -A order_input -p ICMP -j icmp_filter -m comment --comment "Filter icmp packets" || exit 1
	if [ "${#_check_ip_set}" != "0" ]; then
		iptables -A order_input -i ${_server_iface} -p TCP -j in_port_scan -m comment --comment "Monitor for tcp port scans on ${_server_iface}" || exit 1
	fi
	iptables -A order_input -p TCP -j in_tcp -m comment --comment "Allow restricted access to spicific tcp ports" || exit 1
	iptables -A order_input -p UDP -j in_udp -m comment --comment "Filter udp packets" || exit 1
	if [ "${#_admin_ipv4}" != "0" ]; then
		iptables -A order_input -p ALL -i ${_server_iface} -s ${_admin_ipv4} -j ACCEPT -m comment --comment "Allow admin IP address access" || exit 1
		echo '## Note when finished testing either comment above or set to empty'
		echo '#	value to better secure server. IP spoofers could use time-out'
		echo '#	and or lockout differances to derive remote sys-admin IP address.'
		echo '#	If sys-admin is on local NAT only then this will only revial internal'
		echo '#	network address sceem to the observant attackers.'
	else
		echo "Notice ${_script_name} did Not set any input rules for \${_admin_ipv4}"
	fi
	if [ "${#_server_ipv4_bcast}" != "0" ]; then
		iptables -A order_input -p ALL -i ${_lo_iface} -d ${_server_ipv4_bcast} -j ACCEPT -m comment --comment "Allow loopback to talk to broadcast address" || exit 1
		iptables -A order_input -p ALL -i ${_server_iface} -d ${_server_ipv4_bcast} -j ACCEPT -m comment --comment "Allow broadcast address" || exit 1
	fi
	## Accept established and related connections if not dropped by above
	iptables -A order_input -p ALL -i ${_server_iface} -m state --state ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow established and related connections to persist" || exit 1
	## Drop without logging broadcasts that get this far
	#	iptables -A input_filter_order -m pkttype --pk1-type-broadcast -j DROP
	## Log and drop all packets un accepted and return for default polices to kick in
	iptables -A order_input -j LOG --log-prefix "Input died: a=RETURN" -m comment --comment "Log any packet that was not droped or accepted" || exit 1
	iptables -A order_input -j RETURN -m comment --comment "Return packet for default policies to take over" || exit 1
}
