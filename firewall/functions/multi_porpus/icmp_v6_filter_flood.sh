Icmp_v6_filter_flood(){
	if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
		echo '# Populating icmp_filter_v6'
		for _icmpv6_type in ${_icmpv6_allowed_types//,/ }; do
			case ${_icmpv6_type} in
			130|131|132|143|151|152|153)
				ip6tables -A icmp_filter_v6 -s ${_lo_ipv6} -p icmpv6 --icmpv6-type ${_icmpv6_type} -j icmp_flood_v6 -m comment --comment "Jump icmp packet type ${_icmpv6_type} through icmp_flood_v6 chain" || exit 1
			;;
			*)
				if [ "${_icmpv6_type}" -gt "1" ]; then
					ip6tables -A icmp_filter_v6 -p icmpv6 --icmpv6-type ${_icmpv6_type} -j icmp_flood_v6 -m comment --comment "Jump icmp packet type ${_icmpv6_type} through icmp_flood_v6" || exit 1
				else
					echo "## Error ${_icmpv6_type} was not reconized as a number by Icmp_v6_filter_flood function called by ${_script_name}"
					echo '#	This is non-critical but the above will not be added to filtering chain rules'
				fi
			;;
			esac
		done
		ip6tables -A icmp_filter_v6 -j RETURN -m comment --comment "Return un-matched packets for further processing" || exit 1
		echo '#	Populating icmp_flood_v6'
		if [ "${#_check_ip_set}" != "0" ]; then
			ip6tables -A icmp_flood_v6 -p icmpv6 -m recent --set --name ICMPv6_limiter --rsource -m comment --comment "Beguin tacking icmp packet connection" || exit 1
			ip6tables -A icmp_flood_v6 -p icmpv6 -m recent --update --seconds 1 --hitcount 6 --name ICMPv6_limiter --rsource --rttl -m limit --limit 1/sec --limit-burst 1 -j LOG --log-prefix "ICMP flood attemt caught: a=DROP" -m comment --comment "Log attempts to flood server with to many icmp packets" || exit 1
			ip6tables -A icmp_flood_v6 -p icmpv6 -m recent --update --seconds 1 --hitcount 6 --name ICMPv6_limiter --rsource -j DROP -m comment --comment "Drop attempts to flood server with to many icmp packets" || exit 1
		fi
		ip6tables -A icmp_flood_v6 -p icmpv6 -m state --state NEW -m limit --limit 5/minute --limit-burst 100 -j ACCEPT -m comment --comment "Accept new icmp packets that have not been matched" || exit 1
		ip6tables -A icmp_flood_v6 -p icmpv6 -m state --state ESTABLISHED,RELATED -m limit --limit 5/minute --limit-burst 100 -j ACCEPT -m comment --comment "Accept established and related icmp connections with limitations" || exit 1
		ip6tables -A icmp_flood_v6 -p icmpv6 -j DROP -m comment --comment "Drop any abusive connection or un-matched icmp packet types" || exit 1
		ip6tables -A icmp_flood_v6 -j RETURN -m comment --comment "Return any non-icmpv6 packets acedentally jumped to this chain" || exit 1
	fi
}
