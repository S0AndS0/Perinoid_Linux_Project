Output_ip_filters(){
	echo '## Populating out_bad_ip chain'
	for _bad_ipv4_addr in ${_bad_ipv4_addrs//,/ }; do
		iptables -A out_bad_ip -p ALL -d ${_bad_ipv4_addr} -j REJECT ! -o ${_server_iface} -m comment --comment "Reject connections out of ${_server_iface} to ${_bad_ipv4_addr}" || exit 1
	done
	iptables -A out_bad_ip -p ALL -d ${_lo_ipv4} -j REJECT ! -o ${_lo_iface} -m comment --comment "Reject connections out of ${_lo_ipv4} if not originating from ${_lo_iface}" || exit 1
	iptables -A out_bad_ip -p ALL -d ${_server_ipv4} -o ${_server_iface} -j REJECT -m comment --comment "Reject connections to ${_server_ipv4} from ${_server_iface}" || exit 1
	if [ "${#_external_ipv4}" != "0" ]; then
		iptables -A out_bad_ip -p ALL -d ${_external_ipv4} -o ${_server_iface} -j REJECT -m comment --comment "Reject connections out of ${_server_iface} to IPs claiming to be from ${_external_ipv4}" || exit 1
	fi
	if [ "${#_server_ip2v4}" != "0" ]; then
		iptables -A out_bad_ip -p ALL -d ${_server_ip2v4} -j REJECT ! -o ${_server_iface} -m comment --comment "Reject connections to ${_server_ip2v4} if not originating from ${_server_iface}" || exit 1
	fi
	iptables -A out_bad_ip -j RETURN -m comment --comment "Return un-matched packets" || exit 1
	if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
		ip6tables -A out_bad_ip_v6 -p ALL -s ${_lo_ipv6} -o ${_lo_iface} -j ACCEPT -m comment --comment "Accept packets out of loopback interface" || exit 1
#		ip6tables -A out_bad_ip_v6 -p ALL -s ${_server_ipv6} -o ${_server_iface} -j ACCEPT -m comment --comment "Accept packets out of server interface" || exit 1
		ip6tables -A out_bad_ip_v6 -j RETURN -m comment --comment "Return un-matched packets for further processing" || exit 1
	fi
}
