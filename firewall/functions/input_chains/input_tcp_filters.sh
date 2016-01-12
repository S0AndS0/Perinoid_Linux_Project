Input_tcp_filters(){
	echo '## Populating in_tcp chain'
	for _tcp_port in ${_tcp_ports_list//,/ }; do
		if [ "${#_check_ip_set}" != "0" ]; then
			iptables -A in_tcp -p TCP --dport ${_tcp_port} -j in_woot_filter -m comment --comment "Jump packets though in_woot_filter chain" || exit 1
			iptables -A in_tcp -p TCP --dport ${_tcp_port} -j in_shell_shock -m comment --comment "Jump packets though in_shell_shock chain" || exit 1
			iptables -A in_tcp -p TCP --dport ${_tcp_port} -m recent --name woot_ban --update --seconds 21600 -j DROP -m comment --comment "Update ban time if IP address is found in woot_ban list" || exit 1
			iptables -A in_tcp -p TCP --dport ${_tcp_port} -m recent --name shock_ban --update --seconds 21600 -j DROP -m comment --comment "Update ban time if IP address is found in shock_ban list" || exit 1
			iptables -A in_tcp -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --name limit_${_tcp_port} --set -m comment --comment "Start tracking spiciffic connection to ${_tcp_port} port" || exit 1
			iptables -A in_tcp -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_incoming_tcp_update_seconds:-60} --hitcount ${_incoming_tcp_hitcount:-8} --rttl --name limit_${_tcp_port} -j LOG --log-prefix "TCP flood ${_tcp_port}" -m comment --comment "Log attempts to flood ${_tcp_port} port" || exit 1
			iptables -A in_tcp -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_incoming_tcp_update_seconds:-60} --hitcount ${_incoming_tcp_hitcount:-8} --rttl --name limit_${_tcp_port} -j DROP -m comment --comment "Drop flooding attempts to ${_tcp_port} port" || exit 1
		fi
		iptables -A in_tcp -p TCP --tcp-flags RST RST --dport ${_tcp_port} -m limit --limit 2/second --limit-burst 2 -j ACCEPT -m comment --comment "Mitigate Smurf attacks from excesive RST packets" || exit 1
		iptables -A in_tcp -p TCP --tcp-flags RST RST --dport ${_tcp_port} -m limit --limit 2/second --limit-burst 3 -j DROP -m comment --comment "Drop Smurf attacks from excesive RST packets" || exit 1
		iptables -A in_tcp -p TCP --dport ${_tcp_port} -m limit --limit ${_incoming_tcp_burst_minute:-25}/minute --limit-burst ${_incoming_tcp_burst_limit:-100} -j ACCEPT -m comment --comment "Accept connections that do not attempt to flood ${_tcp_port} port" || exit 1
		iptables -A in_tcp -p TCP --dport ${_tcp_port} -m limit --limit ${_incoming_tcp_burst_minute:-25}/minute --limit-burst $((${_incoming_tcp_burst_limit:-100}+1)) -j DROP -m comment --comment "Drop connections that attempt to flood ${_tcp_port} port" || exit 1
	done
	iptables -A in_tcp -p TCP -j RETURN -m comment --comment "Return un-matched packets for further processing." || exit 1
}
