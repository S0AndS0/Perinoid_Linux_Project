Write_iptables_chains(){
	echo '## Making new chains'
	iptables -N in_bad_packets
	if [ "${#_check_ip_set}" != "0" ]; then
		iptables -N in_port_scan
		iptables -N in_woot_filter
		iptables -N in_woot_ban
		iptables -N in_shell_shock
		iptables -N shell_shock_ban
	fi
	iptables -N icmp_filter
	iptables -N icmp_flood
	iptables -N in_udp
	iptables -N out_udp
	iptables -N in_tcp
	iptables -N out_tcp
	iptables -N in_bad_ip
	iptables -N out_bad_ip
	iptables -N order_input
	iptables -N order_output
	#iptables -N order_forward
	if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
		ip6tables -N in_bad_ip_v6
		ip6tables -N out_bad_ip_v6
		ip6tables -N icmp_filter_v6
		ip6tables -N icmp_flood_v6
		ip6tables -N in_udp_v6
		ip6tables -N out_udp_v6
		ip6tables -N in_tcp_v6
		ip6tables -N out_tcp_v6
		ip6tables -N order_input_v6
		ip6tables -N order_output_v6
	fi
}
