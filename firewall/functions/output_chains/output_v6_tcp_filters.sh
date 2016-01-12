Output_v6_tcp_filters(){
	if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
		echo '## Populating out_tcp_v6 chain'
		for _tcp_port in ${_tcp_ports_list//,/ }; do
			if [ "${#_check_ip_set}" != "0" ]; then
				ip6tables -A out_tcp_v6 -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --set --name limit_${_tcp_port}_v6 || exit 1
				ip6tables -A out_tcp_v6 -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_outgoing_tcp_update_seconds:-60} --hitcount ${_outgoing_tcp_hitcount:-8} --rttl --name limit_${_tcp_port}_v6 -j LOG --log-prefix "TCP flooding port ${_tcp_port}" || exit 1
				ip6tables -A out_tcp_v6 -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_outgoing_tcp_update_seconds:-60} --hitcount ${_outgoing_tcp_hitcount:-8} --rttl --name limit_${_tcp_port}_v6 -j DROP || exit 1
			fi
		ip6tables -A out_tcp_v6 -p TCP --dport ${_tcp_port} -m limit --limit ${_outgoing_tcp_burst_minute:-25}/minute --limit-burst ${_outgoing_tcp_burst_limit:-100} -j ACCEPT || exit 1
		done
		ip6tables -A out_tcp_v6 -p TCP -j RETURN || exit 1
	fi
}
