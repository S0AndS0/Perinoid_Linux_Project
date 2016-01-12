Input_bad_packets(){
	echo '## Populating in_bad_packets chain'
	iptables -A in_bad_packets -p ALL --fragment -j DROP -m comment --comment "Drop all fragmented packets" || exit 1
	iptables -A in_bad_packets -p ALL -m state --state INVALID -j DROP -m comment --comment "Drop all invalid packets" || exit 1
	iptables -A in_bad_packets -p TCP ! --syn -m state --state NEW -j DROP -m comment --comment "Drop new non-syn packets" || exit 1
	iptables -A in_bad_packets -p TCP --tcp-flags ALL NONE -j DROP -m comment --comment "Drop NULL scan" || exit 1
	iptables -A in_bad_packets -p TCP --tcp-flags ALL ALL -j DROP -m comment --comment "Drop XMAS scan"|| exit 1
	iptables -A in_bad_packets -p TCP --tcp-flags ALL FIN,URG,PSH -j DROP -m comment --comment "Drop stealth scan 1" || exit 1
	iptables -A in_bad_packets -p TCP --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP -m comment --comment "Drop pscan 1"|| exit 1
	iptables -A in_bad_packets -p TCP --tcp-flags SYN,FIN SYN,FIN -j DROP -m comment --comment "Drop pscan 2" || exit 1
	iptables -A in_bad_packets -p TCP --tcp-flags FIN,RST FIN,RST -j DROP -m comment --comment "Drop pscan 3" || exit 1
	iptables -A in_bad_packets -p TCP --tcp-flags SYN,RST SYN,RST -j DROP -m comment --comment "Drop SYN-RST scan" || exit 1
	iptables -A in_bad_packets -p TCP --tcp-flags ACK,URG URG -j DROP -m comment --comment "Drop URG scans" || exit 1
	iptables -A in_bad_packets -p TCP --tcp-flags ALL SYN,FIN -j DROP -m comment --comment "Drop SYNFIN scan" || exit 1
	iptables -A in_bad_packets -p TCP --tcp-flags ALL URG,PSH,FIN -j DROP -m comment --comment "Drop nmap Xmas scan" || exit 1
	iptables -A in_bad_packets -p TCP --tcp-flags ALL FIN -j DROP -m comment --comment "Drop FIN scan" || exit 1
	iptables -A in_bad_packets -p TCP --tcp-flags ALL URG,PSH,SYN,FIN -j DROP -m comment --comment "Drop nmap-id scan" || exit 1
	iptables -A in_bad_packets -j RETURN -m comment --comment "Return un-matched packets for further processing" || exit 1
}
