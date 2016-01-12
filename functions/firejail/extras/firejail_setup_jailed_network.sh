Firejail_setup_jailed_network(){
	Arg_checker "${@:---help='Firejail_setup_jailed_network' --exit='# [Firejail_setup_jailed_network] # Failed to be read argments'}" -ep='Firejail_setup_jailed_network'
	_external_interface="${_firejail_host_interface:-eth0}"
	_jailed_interface="${_firejail_bridge_interface:-br0}"
	_jailed_nat_host="${_firejail_bridge_ipv4:-10.10.20.1}/24"
	_jailed_nat_range="${_firejail_nat_ipv4:-10.10.20.0}/24"
	_arg="${_firejail_bridge_forward:-enabled}"
	case $_arg in
		enabled|yes)
			brctl addbr $_jailed_interface
			ifconfig $_jailed_interface $_jailed_nat_host
			echo '1' > /proc/sys/net/ipv4/ip_forward
			iptables -t nat -A PREROUTING -p tcp --dport $_dport -j DNAT --to ${_jailed_nat_range}:${_dport}
			iptables -A FORWARD -i $_jailed_interface -m state --state NEW,INVALID -j DROP
			ipatbles -A INPUT -i $_jailed_interface -m state --state NEW,INVALID -j DROP
			iptables -t nat -A POSTROUTING -o $_external_interface -s $_jailed_nat_range -j MASQUERADE
		;;
		disabled|no)
			echo "0" > /proc/sys/net/ipv4/ip_forward
			iptables -t nat -D POSTROUTING -o $_external_interface -s $_jailed_nat_range -j MASQUERADE
		;;
	esac
}
### Firejail_setup_jailed_network_help firejail_setup_jailed_network_help firejail_setup_jailed_network.sh
#	File:	${_script_dir}/functions/firejail/extras/firejail_setup_jailed_network.sh
#	Argument	Variable			Default
#	[-FBF=...]	_firejail_bridge_forward	enabled
#	[-FBI=...]	_firejail_bridge_interface	br0
#	[-FHI=...]	_firejail_host_interface	eth0
#	[-FBipv4=...]	_firejail_bridge_ipv4		10.10.20.1
#	[-FNipv4=...]	_firejail_nat_ipv4		10.10.20.0
#	Notes:	This function writes iptables rules that allows a firejailed bridge interface to comunicate
#		with the host system's server interface. Depending on whether or not forwarding is enabled
#		this function may also allow external IP addresses to comunicate through the bridged interface
#		for example; allowing nginx services to serve clients outside your system NAT
####
