Icmp_v4_flood(){
	echo '## Populating icmp_flood chain'
	if [ "${#_check_ip_set}" != "0" ]; then
		iptables -A icmp_flood -p ICMP -m recent --set --name ICMP_limiter --rsource -m comment --comment "Beguin tracking icmp connection" || exit 1
		iptables -A icmp_flood -p ICMP -m recent --update --seconds 1 --hitcount 6 --name ICMP_limiter --rsource --rttl -m limit --limit 1/sec --limit-burst 1 -j LOG --log-prefix "ICMP flood attemt caught: a=DROP" -m comment --comment "Log attepts to flood server with icmp packets" || exit 1
		iptables -A icmp_flood -p ICMP -m recent --update --seconds 1 --hitcount 6 --name ICMP_limiter --rsource -j DROP -m comment --comment "Drop connections that attempt to flood server with icmp packets" || exit 1
	fi
	iptables -A icmp_flood -p ICMP -m state --state NEW -m limit --limit 5/minute --limit-burst 100 -j ACCEPT -m comment --comment "Accept non-flooding icmp packets" || exit 1
	iptables -A icmp_flood -p ICMP -m state --state ESTABLISHED,RELATED -m limit --limit 5/minute --limit-burst 100 -j ACCEPT -m comment --comment "Accept established and related icmp connections with limitations" || exit 1
	iptables -A icmp_flood -p ICMP -j DROP -m comment --comment "Drop un-accepted icmp packets" || exit 1
	iptables -A icmp_flood -j RETURN -m comment --comment "Return packets acedentally jumped to this chain" || exit 1
}
