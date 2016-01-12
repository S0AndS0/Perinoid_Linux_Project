Output_ban_filters(){
	if [ "${#_check_ip_set}" != "0" ]; then
		echo "## Populating out_port_scan"
		iptables -A in_port_scan -o ${_server_iface} -p TCP -m state --state NEW -m recent --set -o ${_server_iface} -p TCP -m comment --comment "Monitor number of new conncetions out of ${_server_iface}" || exit 1
		iptables -A in_port_scan -o ${_server_iface} -p TCP -m state --state NEW -m recent --update --seconds 30 --hitcout 20 -j REJECT -m comment --comment "Reject connections to an IP out of ${_server_iface} before flooding that connection" || exit 1
		iptables -A in_port_scan -j RETURN -m comment --comment "Return un-matched packets for further processing" || exit 1
	fi
}
