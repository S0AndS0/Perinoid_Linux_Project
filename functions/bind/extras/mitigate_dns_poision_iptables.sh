Mitigate_dns_poision_iptables(){
	Arg_checker "${@:---help='Mitigate_dns_poision_iptables' --exit='# [] # Failed to be read arguments'}" -ep='Mitigate_dns_poision_iptables'
	_source_ip="${_bind9_ipv4:-127.0.0.1}"
	_destination_port="${_bind9_port:-53}"
	echo "## Notice 1 : Mitigate_dns_poision_iptables function is now modifying your systems postrouting"
	echo "#	nat routing table for [${_source_ip]} with the destination port [${_destination_port}] to"
	echo "#	have a randomized source port assigned. Please see following link for source of mitigation rule."
	echo "#	http://www.cipherdyne.org/blog/2008/07/mitigating-dns-cache-poisoning-attacks-with-iptables.html"
	iptables -t nat -I POSTROUTING 1 -p udp -s ${_source_ip} --dport ${_destination_port} -j SNAT --to ${_source_port} --random
	echo "#	Notice 2 : Mitigation_dns_poision_iptables function is now modifying your systems timeout"
	echo "#	to be 10 seconds for UDP conntrack state tracking. Combined with above iptables rule and new"
	echo "#	DNS requests will be placed with random source port to new servers and after 10 seconds, choose"
	echo "#	new random source port even if the destionation address has not changed."
	sysctl -w net.netfilter.nf_conntrack_udp_timeout=10
	echo "#	"
}
