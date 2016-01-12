Input_v6_tcp_filters(){
	if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
		echo '## Populating in_tcp chain_v6'
		for _tcp_port in ${_tcp_ports_list//,/ }; do
			if [ "${#_check_ip_set}" != "0" ]; then
				ip6tables -A in_tcp_v6 -p TCP --dport ${_tcp_port} -m recent --name woot_ban --update --seconds 21600 -j DROP -m comment --comment "Update and drop packet if IP is in woot_ban list" || exit 1
				ip6tables -A in_tcp_v6 -p TCP --dport ${_tcp_port} -m recent --name shock_ban --update --seconds 21600 -j DROP -m comment --comment "Update and drop packet if IP is in shock_ban list" || exit 1
				ip6tables -A in_tcp_v6 -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --set --name limit_${_tcp_port} -m comment --comment "Start tracking new syn connections to ${_tcp_port}" || exit 1
				ip6tables -A in_tcp_v6 -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_incoming_tcp_update_seconds:-60} --hitcount ${_incoming_tcp_hitcount:-8} --rttl --name limit_${_tcp_port} -j LOG --log-prefix "TCP flooding port ${_tcp_port}" -m comment --comment "Log attempts to flood ${_tcp_port}" || exit 1
				ip6tables -A in_tcp_v6 -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_incoming_tcp_update_seconds:-60} --hitcount ${_incoming_tcp_hitcount:-8} --rttl --name limit_${_tcp_port} -j DROP -m comment --comment "Drop flooding atepmts to ${_tcp_port}" || exit 1
			fi
			ip6tables -A in_tcp_v6 -p TCP --dport ${_tcp_port} -m limit --limit ${_incoming_tcp_burst_minute:-25}/minute --limit-burst ${_incoming_tcp_burst_limit:-100} -j ACCEPT -m comment --comment "Allow mitigated access to ${_tcp_port}"|| exit 1
		done
		ip6tables -A in_tcp_v6 -p TCP -j RETURN -m comment --comment "Return un-matched packets for further processing or logging" || exit 1
	fi
}
