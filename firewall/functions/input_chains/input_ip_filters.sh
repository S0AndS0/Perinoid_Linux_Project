Input_ip_filters(){
	echo '## Populating in_bad_ip chain'
	for _bad_ipv4_addr in ${_bad_ipv4_addrs//,/ }; do
		iptables -A in_bad_ip -p ALL -i ${_server_iface} -s ${_bad_ipv4_addr} -d ${_server_ipv4} -j DROP -m comment --comment "Drop spoofed packets from claiming to be from ${_bad_ipv4_addr}" || exit 1
	done
	iptables -A in_bad_ip -p ALL -s ${_lo_ipv4} -j DROP ! -i ${_lo_iface} -m comment --comment "Drop spoofed packets claiming to be from loopback" || exit 1
	iptables -A in_bad_ip -p ALL -s ${_server_ipv4} -i ${_server_iface} -j DROP -m comment --comment "Drop spoofed packets claiming to be from server NAT IP" || exit 1
	if [ "${#_external_ipv4}" != "0" ]; then
		iptables -A in_bad_ip -p ALL -s ${_external_ipv4}  -i ${_server_iface} -j DROP -m comment --comment "Drop spoofed packets claiming to be from server external IP" || exit 1
	fi
	#iptables -A in_bad_ip -p ALL -s ${_server_ipv4} -i ${_server_iface} -j DROP || exit 1
	if [ "${#_server_ip2v4}" != "0" ]; then
		iptables -A in_bad_ip -p ALL -s ${_server_ip2v4} -j DROP ! -i ${_server_iface} -m comment --comment "Drop spoofed packets claming to be from secondery IP" || exit 1
	fi
	iptables -A in_bad_ip -j RETURN -m comment --comment "Return un-matched packets for further processing." || exit 1
}
