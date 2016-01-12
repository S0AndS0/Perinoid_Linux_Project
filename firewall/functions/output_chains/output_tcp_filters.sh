Output_tcp_filters(){
	echo '## Populating out_tcp chain'
	for _tcp_port in ${_tcp_ports_list//,/ }; do
		if [ "${#_check_ip_set}" != "0" ]; then
			iptables -A out_tcp -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --set --name limit_${_tcp_port} -m comment --comment "Beguin tracking out-going tcp connections to port ${_tcp_port}" || exit 1
			iptables -A out_tcp -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_outgoing_tcp_update_seconds:-60} --hitcount ${_outgoing_tcp_hitcount:-8} --rttl --name limit_${_tcp_port} -j LOG --log-prefix "TCP flooding port ${_tcp_port}" -m comment --comment "Log atempts to flood port ${_tcp_port} from your server" || exit 1
			iptables -A out_tcp -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_outgoing_tcp_update_seconds:-60} --hitcount ${_outgoing_tcp_hitcount:-8} --rttl --name limit_${_tcp_port} -j REJECT -m comment --comment "Reject attempts to flood port ${_tcp_port} from your server" || exit 1
		fi
		iptables -A out_tcp -p TCP --dport ${_tcp_port} -m limit --limit ${_outgoing_tcp_burst_minute:-25}/minute --limit-burst ${_outgoing_tcp_burst_limit:-100} -j ACCEPT -m comment --comment "Accept with conditions new connections to port ${_tcp_port} from your server" || exit 1
	done
	iptables -A out_tcp -p TCP -j RETURN -m comment --comment "Return un-matched packets for further processing." || exit 1
}
