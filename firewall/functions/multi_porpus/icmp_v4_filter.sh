Icmp_v4_filter(){
	echo '## Populating icmp_filter chain'
	iptables -A icmp_filter -p ICMP --icmp-type address-mask-request -j DROP -m comment --comment "Drop address mask requests Smurf attack" || exit 1
	iptables -A icmp_filter -p ICMP --icmp-type timestamp-request -j DROP -m comment --comment "Drop timestamp requests Smurf attack" || exit 1
	iptables -A icmp_filter -p ICMP -m u32 ! --u32 "480x3FFF=0" -j DROP -m comment --comment "Drop icmp packets whose fagmentation flag is not 0" || exit 1
	iptables -A icmp_filter -p ICMP -m length --lenth 1492:65535 -j DROP -m comment --comment "Drop oversized icmp packets" || exit 1
	for _icmp_type in ${_icmpv4_allowed_types//,/ }; do
		iptables -A icmp_filter -p ICMP --icmp-type ${_icmp_type} -m state --state NEW -j icmp_flood -m comment --comment "Jump icmp packet type ${_icmp_type} though icmp_flood to mittigate abuse" || exit 1
	done
	iptables -A icmp_filter -j RETURN -m comment --comment "Return un-matched packets for further processing." || exit 1
}
