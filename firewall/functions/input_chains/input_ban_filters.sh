Input_ban_filters(){
	if [ "${#_check_ip_set}" != "0" ]; then
		echo "## Populating in_port_scan"
		iptables -A in_port_scan -i ${_server_iface} -p TCP -m state --state NEW -m recent --set -m comment --comment "Monitor number of new conncetions to ${_server_iface}" || exit 1
		iptables -A in_port_scan -i ${_server_iface} -p TCP -m state --state NEW -m recent --update --seconds 30 --hitcout 10 -j DROP -m comment --comment "Drop packets when to many new connections are attempted on ${_server_iface}" || exit 1
		iptables -A in_port_scan -j RETURN -m comment --comment "Return un-matched packets for further processing" || exit 1
		echo "## Populating in_woot_filter and in_woot_ban"
		iptables -A in_woot_filter -m recent -p TCP --syn --set -m comment --comment "Check for new tcp syn connection" || exit 1
		iptables -A in_woot_filter -m recent -p TCP --tcp-flags PSH,SYN,ACK ACK --update -m comment --comment "Update if connection is becoming established" || exit 1
		iptables -A in_woot_filter -m recent -p TCP --tcp-flags PSH,SYN PSH,ACK --remove -m string --to 80 --algo bm --hex-string '|485454202f312e310d0a0d0a|' -j in_woot_ban -m comment --comment "Check for w00t like string and jump to in_woot_ban if found" || exit 1
		iptables -A in_woot_filter -j RETURN -m comment --comment "Return un-matched packets for further processing" || exit 1
		iptables -A in_woot_ban -m recent --set --name woot_ban -p TCP -j REJECT --reject-with tcp-reset -m comment --comment "Ban any TCP packet coming to this chain" || exit 1
		iptables -A in_woot_ban -j RETURN -m comment --comment "Return any non-tcp packet that some how came to this chain, fool proofing" || exit 1
		echo "## Populating in_shell_shock and shell_shock_ban"
		iptables -A in_shell_shock -m recent -p TCP --syn --set -m comment --comment "Check for new syn connection" || exit 1
		iptables -A in_shell_shock -m recent -p TCP --tcp-flags PSH,SYN,ACK ACK --update -m comment --comment "Update if connection is becoming established" || exit 1
		iptables -A in_shell_shock -m recent -p TCP --tcp-flags PSH,SYN PSH,ACK --remove -m string --to 80 --algo bw --hex-string '|28 29 20 7B|' -j shell_shock_ban -m comment --comment "Check for shell shock attempt and jump to shell_shock_ban if found" || exit 1
		iptables -A in_shell_shock -j RETURN -m comment --comment "Return un-matched packets for further processing" || exit 1
		iptables -A shell_shock_ban -m recent --set --name shock_ban -p TCP -j REJECT --reject-with tcp-reset -m comment --comment "Ban any recent packet ariving to this chain" || exit 1
		iptables -A shell_shock_ban -j RETURN -m comment --comment "Return un-matched packets for further processing" || exit 1
	fi
}
