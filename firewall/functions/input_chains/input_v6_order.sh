Input_v6_order(){
	if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
		ip6tables -A order_input_v6 -p ALL -j in_bad_ip_v6 -m comment --comment "Filter all incoming packets through in_bad_ip_v6 chain" || exit 1
		ip6tables -A order_input_v6 -p ALL -i ${_lo_iface} -s ${_lo_ipv6} -j ACCEPT -m comment --comment "Accept packets from loopback interface" || exit 1
		ip6tables -A order_input_v6 -p icmpv6 -j icmp_filter_v6 -m comment --comment "Filter icmp packets through icmp_filter_v6 chain" || exit 1
		ip6tables -A order_input_v6 -p udp -j in_udp_v6 -m comment --comment "Filter udp packets through in_udp_v6 chain" || exit 1
		ip6tables -A order_input_v6 -p TCP -j in_tcp_v6 -m comment --comment "Filter tcp packets through in_tcp_v6 chain" || exit 1
		ip6tables -A order_input_v6 -p ALL -i ${_server_iface} -m state --state ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Accept established and related connections that get past filters" || exit 1
		if [ "${#_admin_ipv6}" != "0" ]; then
			ip6tables -A order_input_v6 -p ALL -i ${_server_iface} -s ${_admin_ipv6} -j ACCEPT -m comment --comment "Allow ${_admin_ipv6} to speek freely with server" || exit 1
			echo '## Note when finished testing either comment above or set to empty'
			echo '#	value to better secure server. IP spoofers could use time-out'
			echo '#	and or lockout differances to derive remote sys-admin IP address.'
			echo '#	If sys-admin is on local NAT only then this will only revial internal'
			echo '#	network address sceem to the observant attackers.'
		else
			echo "Notice ${_script_name} did Not set any input rules for \${_admin_ipv6}"
		fi
		ip6tables -A order_input_v6 -j LOG --log-prefix "Input died: a=RETURN" -m comment --comment "Logs unpmatched packets prior to returning to default input chain" || exit 1
		ip6tables -A order_input_v6 -j RETURN -m comment --comment "Returns un-matched packets for default policies to take effect." || exit 1
	fi
}
