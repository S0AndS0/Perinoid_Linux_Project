Output_v6_order(){
	if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
		ip6tables -A order_output_v6 -p ALL -j out_bad_ip_v6
		ip6tables -A order_output_v6 -p ALL -o ${_lo_iface} -j ACCEPT
		ip6tables -A order_output_v6 -p icmpv6 -j icmp_filter_v6 || exit 1
		ip6tables -A order_output_v6 -p udp -j out_udp_v6
		ip6tables -A order_output_v6 -p TCP -j out_tcp_v6
		ip6tables -A order_output_v6 -p ALL -m state --state ESTABLISHED,RELATED -j ACCEPT || exit 1
		if [ "${#_admin_ipv6}" != "0" ]; then
			ip6tables -A order_output -p ALL -o ${_server_iface} -s ${_admin_ipv6} -j ACCEPT || exit 1
			echo '## Note when finished testing either comment above or set to empty'
			echo '#	value to better secure server. IP spoofers could use time-out'
			echo '#	and or lockout differances to derive remote sys-admin IP address.'
			echo '#	If sys-admin is on local NAT only then this will only revial internal'
			echo '#	network address sceem to the observant attackers.'
		else
			echo "Notice ${_script_name} did Not set any input rules for \${_admin_ipv6}"
		fi
		ip6tables -A order_output_v6 -j LOG --log-prefix "Output died: a=RETURN" -m comment --comment "Logs un-matched packets prior to returning them to default output chain" || exit 1
		ip6tables -A order_output_v6 -j RETURN -m comment --comment "Returns un-matched packets for default policies to take effect." || exit 1
	fi
}
