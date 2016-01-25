#!/bin/bash
 _admin_ipv4=""
 _admin_ipv6=""
 _external_ipv4=""
 _make_bridge_forwarding="no"
# _bridge_internal_iface="br0"
 _bridge_port_pares="80:8080,443:8081"
 _enable_forwarding="no"
 _policy_forward="ACCEPT"
 _policy_input="ACCEPT"
 _policy_output="ACCEPT"
 _dns_port="53"
 _ssh_port="22,2489"
 _http_port="80"
 _ssl_port="443"
 _incoming_tcp_update_seconds="60"
 _incoming_tcp_hitcount="8"
 _incoming_tcp_update_seconds="300"
 _incoming_tcp_burst_minute="25"
 _incoming_tcp_burst_limit="100"
 _outgoing_tcp_update_seconds="60"
 _outgoing_tcp_hitcount="8"
 _outgoing_tcp_update_seconds="300"
 _outgoing_tcp_burst_minute="25"
 _outgoing_tcp_burst_limit="100"
#	loopback iface
 _lo_iface=$(ip addr show up lo | awk '/1: lo/{gsub(":",""); print $2}')
#	loopback IPv4 address
 _lo_ipv4=$(ip addr show up lo | grep -vE 'inet6' | awk '/inet/{print $2}')
#	loopback IPv6 address if available
 _lo_ipv6=$(ip addr show up lo | awk '/inet6/{print $2}')
#	First live (non-lo interface) interface to variable
 _server_iface=$(ip addr show up | grep -vE 'link|loopback|inet' | awk '/eth|wlan|ppp/{gsub(":",""); print $2}' | head -n1)
 _bridge_external_iface="${_server_iface}"
 _bridge_internal_iface=${_bridge_internal_iface:-$(ip addr show up | grep -vE 'link|loopback|inet' | awk '/eth|wlan|ppp/{gsub(":",""); print $2}' | head -n2 | tail -n1 | grep -vE "${_server_iface}")}
#	First live (non-lo interface) IP address to variable
#_server_ipv4=$(ip addr show up | grep -vE 'link' | grep -A3 -E 'eth|wlan|ppp' | awk '/inet/{print $2}' | head -n1)
 _server_ipv4=$(ip addr show up ${_server_iface} | grep -vE 'link' | awk '/inet/{gsub("/"," "); print $2}' | head -n1)
#	IPv6 non-lo address if available for server interface
 _server_ipv6=$(ip addr show up ${_server_iface} | awk '/inet6/{print $2}')
#	Second live (non-lo interface) IP address to variable
 _server_ip2v4=$(ip addr show up | grep -vE 'link' | grep -A3 -E 'eth|wlan|ppp' | awk '/inet/{print $2}' | head -n2 | tail -n1)
#	Set with DNS request if not set by user
if [ "${#_external_ipv4}" = "0" ]; then
	if [ -x "$(which dig)" ]; then
		 _external_ipv4=$(dig +short myip.opendns.com @resolver1.opendns.com)
		echo "# Notice external IP set by ${_script_name} by checking opendns.com"
	fi
	if [ -x "$(which wget)" ]; then
		 _external_ipv4=$(wget -q -O - checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
		echo "# Notice external IP set by ${_script_name} by checking opendns.org"
	fi
	 _external_ipv4=${_external_ipv4}
	echo "#	${_external_ipv4}"
fi
 _bridge_ipv4_addr="${_server_ip2v4:-10.10.20.1}"
#	Server broadcast IPv4 address
 _server_ipv4_bcast=$(ip addr show up ${_server_iface} | grep -E "${_server_iface}" | awk '/brd/{print $4}')
#	SSH server port (first one only)
#_ssh_port=$(grep -vE '#' /etc/ssh/sshd_config | awk '/Port/{print $2}' | head -n1)
 _ssh_port=$(grep -vE '#' /etc/ssh/sshd_config | awk '/Port/{print $2}')
#	List of bad addresses to loop through
 _bad_ipv4_addrs="0.0.0.0/8,127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,162.168.0.0/16,224.0.0.0/3"
#	List of TCP service ports
 _tcp_ports_list="${_http_port},${_ssl_port},${_ssh_port}"
#	List of dns servers to allow UDP connections to and from. leave commented
#	to have script use system defaults found in /etc/resolv.conf automaticly
#_dns_addresses="8.8.8.8 8.8.4.4"
#	Following checks if iptables may use "--set" features for filtering packets
#	variable will either contain file paths to kernal modules or nothing at all.
 _check_ip_set=$(find /lib/modules/ -name ip_set.ko)
#	IPv4 icmp types to allow
 _icmpv4_allowed_types="0,3,8,11"
#	IPv6 icmp types to allow
 _icmpv6_allowed_types="1,2,3,4,128,129,130,131,133,134,135,136,141,142,143,148,149,151,152,153"
#	Note above two variables are filtered through flood checks to mitigate abuse both to and
#	from device. Additionally the icmpv6 filter automaticly assignes the following icmp types
#	to only be allowed from loopback; 130,131,132,143,151,152,153 to further restrict attack
#	serface available.
 _name_backup="old_firewall"
 _old_backup="${_name_backup}"
_script_name="${0##*/}"
_script_dir="${0%/*}"
echo "${_script_name}"
echo "${_script_dir}"
echo -n ""
read _ui
if [ "${#_check_ip_set}" != "0" ]; then
	echo "#	Notice ip_set.ko detected"
	${_check_ip_set}
	echo "#	${_script_name} will be running with more advanced features"
else
	echo "#	Notice ${_script_name} could not find ip_set.ko under /lib/modules/"
	echo '#	some features will not be available do to kernel limitations.'
fi
if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
	echo "#	Notice ${_script_name} detected IP v6 for ${_lo_iface} and ${_server_iface}"
	echo "#	${_lo_iface} ${_lo_ipv6}"
	echo "#	${_server_iface} ${_server_ipv6}"
else
	echo "#	notice ${_script_name} did Not detect IP v6 addresses for ${_lo_iface} and ${_server_iface}"
fi
echo '## Making new chains'
iptables -N in_bad_packets
if [ "${#_check_ip_set}" != "0" ]; then
	iptables -N in_woot_filter
	iptables -N in_woot_ban
	iptables -N in_shell_shock
	iptables -N shell_shock_ban
fi
iptables -N icmp_filter
iptables -N icmp_flood
iptables -N in_udp
iptables -N out_udp
iptables -N in_tcp
iptables -N out_tcp
iptables -N in_bad_ip
iptables -N out_bad_ip
iptables -N order_input
iptables -N order_output
#iptables -N order_forward
if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
	ip6tables -N in_bad_ip_v6
	ip6tables -N out_bad_ip_v6
	ip6tables -N icmp_filter_v6
	ip6tables -N icmp_flood_v6
	ip6tables -N in_udp_v6
	ip6tables -N out_udp_v6
	ip6tables -N in_tcp_v6
	ip6tables -N out_tcp_v6
	ip6tables -N order_input_v6
	ip6tables -N order_output_v6
fi
if [ "${#_check_ip_set}" != "0" ]; then
	echo "## Populating in_woot_filter and in_woot_ban"
	iptables -A in_woot_filter -m recent -p TCP --syn --set
	iptables -A in_woot_filter -m recent -p TCP --tcp-flags PSH,SYN,ACK ACK --update
	iptables -A in_woot_filter -m recent -p TCP --tcp-flags PSH,SYN PSH,ACK --remove -m string --to 80 --algo bm --hex-string '|485454202f312e310d0a0d0a|' -j in_woot_ban
	iptables -A in_woot_filter -j RETURN
	iptables -A in_woot_ban -m recent --set --name woot_ban -p TCP -j REJECT --reject-with tcp-reset
	echo "## Populating in_shell_shock and shell_shock_ban"
	iptables -A in_shell_shock -m recent -p TCP --syn --set
	iptables -A in_shell_shock -m recent -p TCP --tcp-flags PSH,SYN,ACK ACK --update
	iptables -A in_shell_shock -m recent -p TCP --tcp-flags PSH,SYN PSH,ACK --remove -m string --to 80 --algo bw --hex-string '|28 29 20 7B|' -j shell_shock_ban || exit 1
	iptables -A shell_shock_ban -m recent --set --name shock_ban -p TCP -j REJECT --reject-with tcp-reset
fi
echo '## Populating icmp_filter chain'
for _icmp_type in ${_icmpv4_allowed_types//,/ }; do
	iptables -A icmp_filter -p ICMP --icmp-type ${_icmp_type} -m state --state NEW -j icmp_flood || exit 1
done
iptables -A icmp_filter -j RETURN || exit 1
echo '## Populating icmp_flood chain'
if [ "${#_check_ip_set}" != "0" ]; then
	iptables -A icmp_flood -p ICMP -m recent --set --name ICMP_limiter --rsource || exit 1
	iptables -A icmp_flood -p ICMP -m recent --update --seconds 1 --hitcount 6 --name ICMP_limiter --rsource --rttl -m limit --limit 1/sec --limit-burst 1 -j LOG --log-prefix "ICMP flood attemt caught: a=DROP" || exit 1
	iptables -A icmp_flood -p ICMP -m recent --update --seconds 1 --hitcount 6 --name ICMP_limiter --rsource -j DROP || exit 1
fi
iptables -A icmp_flood -p ICMP -m state --state NEW -m limit --limit 5/minute --limit-burst 100 -j ACCEPT || exit 1
iptables -A icmp_flood -p ICMP -m state --state ESTABLISHED,RELATED -m limit --limit 5/minute --limit-burst 100 -j ACCEPT || exit 1
iptables -A icmp_flood -p ICMP -j DROP || exit 1
if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
	echo '# Populating icmp_filter_v6'
	for _icmpv6_type in ${_icmpv6_allowed_types//,/ }; do
		case ${_icmpv6_type} in
		130|131|132|143|151|152|153)
			ip6tables -A icmp_filter_v6 -s ${_lo_ipv6} -p icmpv6 --icmpv6-type ${_icmpv6_type} -j icmp_flood_v6
		;;
		*)
			ip6tables -A icmp_filter_v6 -p icmpv6 --icmpv6-type ${_icmpv6_type} -j icmp_flood_v6
		;;
		esac
	done
	ip6tables -A icmp_filter_v6 -j RETURN
	echo '#	Populating icmp_flood_v6'
	ip6tables -A icmp_flood_v6
	if [ "${#_check_ip_set}" != "0" ]; then
		ip6tables -A icmp_flood_v6 -p icmpv6 -m recent --set --name ICMPv6_limiter --rsource || exit 1
		ip6tables -A icmp_flood_v6 -p icmpv6 -m recent --update --seconds 1 --hitcount 6 --name ICMPv6_limiter --rsource --rttl -m limit --limit 1/sec --limit-burst 1 -j LOG --log-prefix "ICMP flood attemt caught: a=DROP" || exit 1
		ip6tables -A icmp_flood_v6 -p icmpv6 -m recent --update --seconds 1 --hitcount 6 --name ICMPv6_limiter --rsource -j DROP || exit 1
	fi
	ip6tables -A icmp_flood_v6 -p icmpv6 -m state --state NEW -m limit --limit 5/minute --limit-burst 100 -j ACCEPT || exit 1
	ip6tables -A icmp_flood_v6 -p icmpv6 -m state --state ESTABLISHED,RELATED -m limit --limit 5/minute --limit-burst 100 -j ACCEPT || exit 1
	ip6tables -A icmp_flood_v6 -j DROP
fi
echo '## Populating in_udp chain'
iptables -A in_udp -p UDP --dport 137 -j DROP || exit 1
iptables -A in_udp -p UDP --dport 138 -j DROP || exit 1
for _dns_addr in ${_dns_addresses:-$(cat /etc/resolv.conf | grep -vE '#' | awk '/nameserver/{print $2}')}; do
	iptables -A in_udp -p UDP -i ${_lo_iface} -s ${_lo_ipv4} -d ${_dns_addr} --dport ${_dns_port} -m state --state ESTABLISHED,RELATED -j ACCEPT || exit 1
	iptables -A in_udp -p UDP -i ${_server_iface} -s ${_server_ipv4} -d ${_dns_addr} --dport ${_dns_port} -m state --state ESTABLISHED,RELATED -j ACCEPT || exit 1
done
iptables -A in_udp -j RETURN || exit 1
echo '## Populating out_udp chain'
iptables -A out_udp -p UDP --sport 137 -j DROP || exit 1
iptables -A out_udp -p UDP --sport 138 -j DROP || exit 1
for _dns_addr in ${_dns_addresses:-$(cat /etc/resolv.conf | grep -vE '#' | awk '/nameserver/{print $2}')}; do
	iptables -A out_udp -p UDP -o ${_lo_iface} -d ${_lo_ipv4} -s ${_dns_addr} --sport ${_dns_port} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT || exit 1
	iptables -A out_udp -p UDP -o ${_server_iface} -d ${_server_ipv4} -s ${_dns_addr} --sport ${_dns_port} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT || exit 1
done
iptables -A out_udp -j RETURN || exit 1
if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
	echo '## Populating in_udp_v6 chain'
	ip6tables -A in_udp_v6 -p UDP --dport 137 -j DROP || exit 1
	ip6tables -A in_udp_v6 -p UDP --dport 138 -j DROP || exit 1
	ip6tables -A in_udp_v6 -p UDP -i ${_lo_iface} -s ${_lo_ipv6} --dport ${_dns_port} -m state --state ESTABLISHED,RELATED -j ACCEPT || exit 1
	ip6tables -A in_udp_v6 -p UDP -i ${_server_iface} -s ${_server_ipv6} --dport ${_dns_port} -m state --state ESTABLISHED,RELATED -j ACCEPT || exit 1
	ip6tables -A in_udp_v6 -j RETURN || exit 1
	echo '## Populating out_udp_v6 chain'
	ip6tables -A out_udp_v6 -p UDP --sport 137 -j DROP || exit 1
	ip6tables -A out_udp_v6 -p UDP --sport 138 -j DROP || exit 1
	ip6tables -A out_udp_v6 -p UDP -o ${_lo_iface} -d ${_lo_ipv6} --sport ${_dns_port} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT || exit 1
	ip6tables -A out_udp_v6 -p UDP -o ${_server_iface} -d ${_server_ipv6} --sport ${_dns_port} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT || exit 1
	ip6tables -A out_udp_v6 -j RETURN || exit 1
fi
echo '## Populating in_tcp chain'
for _tcp_port in ${_tcp_ports_list//,/ }; do
	if [ "${#_check_ip_set}" != "0" ]; then
		iptables -A in_tcp -p TCP --dport ${_tcp_port} -m recent --name woot_ban --update --seconds 21600 -j DROP
		iptables -A in_tcp -p TCP --dport ${_tcp_port} -m recent --name shock_ban --update --seconds 21600 -j DROP
		iptables -A in_tcp -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --set --name limit_${_tcp_port} || exit 1
		iptables -A in_tcp -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_incoming_tcp_update_seconds:-60} --hitcount ${_incoming_tcp_hitcount:-8} --rttl --name limit_${_tcp_port} -j LOG --log-prefix "TCP flooding port ${_tcp_port}" || exit 1
		iptables -A in_tcp -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_incoming_tcp_update_seconds:-60} --hitcount ${_incoming_tcp_hitcount:-8} --rttl --name limit_${_tcp_port} -j DROP || exit 1
	fi
	iptables -A in_tcp -p TCP --dport ${_tcp_port} -m limit --limit ${_incoming_tcp_burst_minute:-25}/minute --limit-burst ${_incoming_tcp_burst_limit:-100} -j ACCEPT || exit 1
done
iptables -A in_tcp -p TCP -j RETURN || exit 1
echo '## Populating out_tcp chain'
for _tcp_port in ${_tcp_ports_list//,/ }; do
	if [ "${#_check_ip_set}" != "0" ]; then
		iptables -A out_tcp -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --set --name limit_${_tcp_port} || exit 1
		iptables -A out_tcp -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_outgoing_tcp_update_seconds:-60} --hitcount ${_outgoing_tcp_hitcount:-8} --rttl --name limit_${_tcp_port} -j LOG --log-prefix "TCP flooding port ${_tcp_port}" || exit 1
		iptables -A out_tcp -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_outgoing_tcp_update_seconds:-60} --hitcount ${_outgoing_tcp_hitcount:-8} --rttl --name limit_${_tcp_port} -j DROP || exit 1
	fi
	iptables -A out_tcp -p TCP --dport ${_tcp_port} -m limit --limit ${_outgoing_tcp_burst_minute:-25}/minute --limit-burst ${_outgoing_tcp_burst_limit:-100} -j ACCEPT || exit 1
done
iptables -A out_tcp -p TCP -j RETURN || exit 1
if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
	echo '## Populating in_tcp chain_v6'
	for _tcp_port in ${_tcp_ports_list//,/ }; do
		if [ "${#_check_ip_set}" != "0" ]; then
			ip6tables -A in_tcp_v6 -p TCP --dport ${_tcp_port} -m recent --name woot_ban --update --seconds 21600 -j DROP
			ip6tables -A in_tcp_v6 -p TCP --dport ${_tcp_port} -m recent --name shock_ban --update --seconds 21600 -j DROP
			ip6tables -A in_tcp_v6 -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --set --name limit_${_tcp_port} || exit 1
			ip6tables -A in_tcp_v6 -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_incoming_tcp_update_seconds:-60} --hitcount ${_incoming_tcp_hitcount:-8} --rttl --name limit_${_tcp_port} -j LOG --log-prefix "TCP flooding port ${_tcp_port}" || exit 1
			ip6tables -A in_tcp_v6 -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_incoming_tcp_update_seconds:-60} --hitcount ${_incoming_tcp_hitcount:-8} --rttl --name limit_${_tcp_port} -j DROP || exit 1
		fi
		ip6tables -A in_tcp_v6 -p TCP --dport ${_tcp_port} -m limit --limit ${_incoming_tcp_burst_minute:-25}/minute --limit-burst ${_incoming_tcp_burst_limit:-100} -j ACCEPT || exit 1
	done
	ip6tables -A in_tcp_v6 -p TCP -j RETURN || exit 1
	echo '## Populating out_tcp_v6 chain'
	for _tcp_port in ${_tcp_ports_list//,/ }; do
		if [ "${#_check_ip_set}" != "0" ]; then
			ip6tables -A out_tcp_v6 -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --set --name limit_${_tcp_port}_v6 || exit 1
			ip6tables -A out_tcp_v6 -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_outgoing_tcp_update_seconds:-60} --hitcount ${_outgoing_tcp_hitcount:-8} --rttl --name limit_${_tcp_port}_v6 -j LOG --log-prefix "TCP flooding port ${_tcp_port}" || exit 1
			ip6tables -A out_tcp_v6 -p TCP --dport ${_tcp_port} -m state --state NEW -m recent --update --seconds ${_outgoing_tcp_update_seconds:-60} --hitcount ${_outgoing_tcp_hitcount:-8} --rttl --name limit_${_tcp_port}_v6 -j DROP || exit 1
		fi
	ip6tables -A out_tcp_v6 -p TCP --dport ${_tcp_port} -m limit --limit ${_outgoing_tcp_burst_minute:-25}/minute --limit-burst ${_outgoing_tcp_burst_limit:-100} -j ACCEPT || exit 1
	done
	ip6tables -A out_tcp_v6 -p TCP -j RETURN || exit 1
fi
echo '## Populating in_bad_ip chain'
for _bad_ipv4_addr in ${_bad_ipv4_addrs//,/ }; do
	iptables -A in_bad_ip -p ALL -i ${_server_iface} -s ${_bad_ipv4_addr} -d ${_server_ipv4} -j DROP || exit 1
done
iptables -A in_bad_ip -p ALL -s ${_lo_ipv4} -j DROP ! -i ${_lo_iface} || exit 1
iptables -A in_bad_ip -p ALL -s ${_server_ipv4} -i ${_server_iface} -j DROP || exit 1
if [ "${#_external_ipv4}" != "0" ]; then
	iptables -A in_bad_ip -p ALL -s ${_external_ipv4}  -i ${_server_iface} -j DROP || exit 1
fi
#iptables -A in_bad_ip -p ALL -s ${_server_ipv4} -i ${_server_iface} -j DROP || exit 1
if [ "${#_server_ip2v4}" != "0" ]; then
	iptables -A in_bad_ip -p ALL -s ${_server_ip2v4} -j DROP ! -i ${_server_iface} || exit 1
fi
iptables -A in_bad_ip -j RETURN || exit 1
echo '## Populating out_bad_ip chain'
for _bad_ipv4_addr in ${_bad_ipv4_addrs//,/ }; do
	iptables -A out_bad_ip -p ALL -d ${_bad_ipv4_addr} -j DROP ! -o ${_server_iface} || exit 1
done
iptables -A out_bad_ip -p ALL -d ${_lo_ipv4} -j DROP ! -o ${_lo_iface} || exit 1
iptables -A out_bad_ip -p ALL -d ${_server_ipv4} -o ${_server_iface} -j DROP || exit 1
if [ "${#_external_ipv4}" != "0" ]; then
	iptables -A out_bad_ip -p ALL -d ${_external_ipv4} -o ${_server_iface} -j DROP || exit 1
fi
if [ "${#_server_ip2v4}" != "0" ]; then
	iptables -A out_bad_ip -p ALL -d ${_server_ip2v4} -j DROP ! -o ${_server_iface} || exit 1
fi
iptables -A out_bad_ip -j RETURN || exit 1
if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
	ip6tables -A out_bad_ip_v6 -p ALL -s ${_lo_ipv6} -o ${_lo_iface} -j ACCEPT || exit 1
	
	ip6tables -A out_bad_ip_v6 -j RETURN
fi
echo '## Populating input_order chain'
iptables -A order_input -p ALL -j in_bad_ip || exit 1
iptables -A order_input -p ALL -i ${_lo_iface} -s ${_lo_ipv4} -j ACCEPT || exit 1
iptables -A order_input -p ALL -j in_bad_packets || exit 1
iptables -A order_input -p ICMP -j icmp_filter || exit 1
iptables -A order_input -p TCP -j in_tcp || exit 1
iptables -A order_input -p UDP -j in_udp || exit 1
if [ "${#_admin_ipv4}" != "0" ]; then
	iptables -A order_input -p ALL -i ${_server_iface} -s ${_admin_ipv4} -j ACCEPT || exit 1
	echo '## Note when finished testing either comment above or set to empty'
	echo '#	value to better secure server. IP spoofers could use time-out'
	echo '#	and or lockout differances to derive remote sys-admin IP address.'
	echo '#	If sys-admin is on local NAT only then this will only revial internal'
	echo '#	network address sceem to the observant attackers.'
else
	echo "Notice ${_script_name} did Not set any input rules for \${_admin_ipv4}"
fi
if [ "${#_server_ipv4_bcast}" != "0" ]; then
	iptables -A order_input -p ALL -i ${_lo_iface} -d ${_server_ipv4_bcast} -j ACCEPT || exit 1
	iptables -A order_input -p ALL -i ${_server_iface} -d ${_server_ipv4_bcast} -j ACCEPT || exit 1
fi
## Accept established and related connections if not dropped by above
iptables -A order_input -p ALL -i ${_server_iface} -m state --state ESTABLISHED,RELATED -j ACCEPT || exit 1
## Drop without logging broadcasts that get this far
#	iptables -A input_filter_order -m pkttype --pk1-type-broadcast -j DROP
## Log and drop all packets un accepted and return for default polices to kick in
iptables -A order_input -j LOG --log-prefix "Input died: a=RETURN" || exit 1
iptables -A order_input -j RETURN || exit 1
echo '## Populating order_output chain'
iptables -A order_output -o ${_lo_iface} -j ACCEPT || exit 1
iptables -A order_output -p ALL -j out_bad_ip || exit 1
iptables -A order_output -p UDP -j out_udp || exit 1
iptables -A order_output -p ICMP -j icmp_filter || exit 1
iptables -A order_output -p TCP -j out_tcp || exit 1
iptables -A order_output -p ALL -m state --state ESTABLISHED,RELATED -j ACCEPT || exit 1
if [ "${#_admin_ipv4}" != "0" ]; then
	iptables -A order_output -p ALL -o ${_server_iface} -s ${_admin_ipv4} -j ACCEPT || exit 1
	echo '## Note when finished testing either comment above or set to empty'
	echo '#	value to better secure server. IP spoofers could use time-out'
	echo '#	and or lockout differances to derive remote sys-admin IP address.'
	echo '#	If sys-admin is on local NAT only then this will only revial internal'
	echo '#	network address sceem to the observant attackers.'
else
	echo "Notice ${_script_name} did Not set any output rules for \${_admin_ipv4}"
fi
iptables -A order_output -j LOG --log-prefix "Output died: a=RETURN" --log-uid || exit 1
iptables -A order_output -j RETURN || exit 1
if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
	ip6tables -A order_input_v6 -p ALL -j in_bad_ip_v6 || exit 1
	ip6tables -A order_input_v6 -p ALL -i ${_lo_iface} -s ${_lo_ipv6} -j ACCEPT || exit 1
	ip6tables -A order_input_v6 -p icmpv6 -j icmp_filter_v6 || exit 1
	ip6tables -A order_input_v6 -p udp -j in_udp_v6
	ip6tables -A order_input_v6 -p TCP -j in_tcp_v6 || exit 1
	ip6tables -A order_input_v6 -p ALL -i ${_server_iface} -m state --state ESTABLISHED,RELATED -j ACCEPT || exit 1
	if [ "${#_admin_ipv6}" != "0" ]; then
		ip6tables -A order_input_v6 -p ALL -i ${_server_iface} -s ${_admin_ipv6} -j ACCEPT || exit 1
		echo '## Note when finished testing either comment above or set to empty'
		echo '#	value to better secure server. IP spoofers could use time-out'
		echo '#	and or lockout differances to derive remote sys-admin IP address.'
		echo '#	If sys-admin is on local NAT only then this will only revial internal'
		echo '#	network address sceem to the observant attackers.'
	else
		echo "Notice ${_script_name} did Not set any input rules for \${_admin_ipv6}"
	fi
	ip6tables -A order_output_v6 -p ALL -j out_bad_ip_v6
	ip6tables -A order_output_v6 -p ALL -o ${_lo_iface} -j ACCEPT
	ip6tables -A order_output_v6 -p icmpv6 -j icmp_filter_v6 || exit 1
	ip6tables -A order_output_v6 -p udp -j out_udp_v6
	ip6tables -A order_output_v6 -p TCP -j out_tcp_v6
	ip6tables -A order_output_v6 -p ALL -m state --state ESTABLISHED,RELATED -j ACCEPT || exit 1
	if [ "${#_admin_ipv6}" != "0" ]; then
		ip6tables -A order_output -p ALL -o ${_server_iface} -s ${_admin_ipv6} -j ACCEPT || exit 1
		echo '## Note when finished testing either comment above or set to empty'
		echo '#	value to better secure server. IP spoofers could use time-out'
		echo '#	and or lockout differances to derive remote sys-admin IP address.'
		echo '#	If sys-admin is on local NAT only then this will only revial internal'
		echo '#	network address sceem to the observant attackers.'
	else
		echo "Notice ${_script_name} did Not set any input rules for \${_admin_ipv6}"
	fi
fi
echo '## Checking forwarding settings'
if [ "${_make_bridged_forwarding}" = "yes" ]; then
	## Detect if bridging interfaces with bridge-utils
	if [ "${#_bridge_external_iface}" != "0" ] && [ "${#_bridge_internal_iface}" != "0" ]; then
		## Test for bridge-utils and if bridge name does not exsist
		if [ -x $(which bridge-utils) ]; then
			_check_for_bridge_fail=$(brctl show ${_bridge_internal_iface} | grep -E 'No such device')
			if [ "${_check_for_bridge_fail}" = "No such debice" ]; then
				brctl addbr ${_bridge_internal_iface}
				ifconfig ${_bridge_internal_iface} ${_bridge_ipv4_addr}/24
			fi
		fi
	fi
fi
if [ "${_enable_forwarding}" = "yes" ] && [ "${#_bridge_external_iface}" != "0" ] && [ "${#_bridge_ipv4_addr}" != "0" ] && [ "${#_bridge_port_pares}" != "0" ]; then
	for _port_pare in ${_bridge_port_pares//,/ }; do
		_bridge_external_port="${_port_pare%:*}"
		_bridge_internal_port="${_port_pare#*:}"
		iptables -t nat -A PREROUTING -p tcp --dport ${_bridge_external_port} -j DNAT --to ${_bridge_ipv4_addr%/*}:${_bridge_internal_port} || exit 1
		echo "Notice IP address ${_bridge_ipv4_addr} on bridge ${_bridge_internal_iface} will recieve TCP packets on ${_bridge_internal_port}"
		echo "originally destened for port ${_bridge_external_port} on interface ${_bridge_external_iface}"
		if [ "${#_bridge_internal_iface}" != "0" ]; then
			iptables -A FORWARD -p TCP -m tcp -i ${_bridge_external_iface} -o ${_bridge_internal_iface} --dport ${_bridge_external_port} -j ACCEPT || exit 1
		else
			iptables -A FORWARD -p TCP -m tcp -i ${_bridge_external_iface} -s ${_bridge_ipv4_addr%/*} --sport ${_bridge_internal_port} --dport ${_bridge_external_port} -j ACCEPT || exit 1
		fi
		if [ "${#_bridge_internal_iface}" = "0" ]; then
			iptables -A FORWARD -p TCP -m tcp -o ${_bridge_external_iface} -d ${_bridge_ipv4_addr%/*} --dport ${_bridge_internal_port} --sport ${_bridge_external_port} -j ACCEPT || exit 1
		fi
	done
	if [ "${#_bridge_internal_iface}" != "0" ]; then
		iptables -A FORWARD -i ${_bridge_external_iface} -o ${_bridge_internal_iface} -m state --state RELATED,ESTABLISHED -j ACCEPT || exit 1
		iptables -A FORWARD -i ${_bridge_internal_iface} -j ACCEPT || exit 1
	fi
	iptables -t nat -A POSTROUTING -o ${_bridge_external_iface} -j MASQUERADE || exit 1
	## Dissable or add other bridge forwarding above this line and re-run to add more
	iptables -A FORWARD -j RETURN || exit 1
fi
echo -n "Attetion ${USER} do you wish to keep current firewall rules active? # "
read -t 120 _user_yn_start_filtering
case ${_user_yn_start_filtering} in
	yes|Yes|Y)
		echo "## Activating iptables chains"
		iptables -I INPUT -j order_input
		iptables -I OUTPUT -j order_output
		if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
			echo "## Activating ip6tables chains"
			ip6tables -I INPUT order_input_v6
			ip6tables -I OUTPUT order_output_v6
		fi
	;;
	no|No|N|*)
		echo "## Notice ${_script_name} will not activate chain filtering"
		echo '#	to enable filtering at a latter time, run the following commands'
		echo '# iptables -I INPUT -j order_input'
		echo '# iptables -I OUTPUT -j order_output'
		if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
			echo '# ip6tables -I INPUT order_input_v6'
			echo '# ip6tables -I OUTPUT order_output_v6'
		fi
	;;
esac
echo "Notice ${_script_name} finished writing iptables rules, summery of rules bellow..."
iptables -S
if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
ip6tables -S
fi
echo 'To keep these settings you must respond "yes" or backups listed will be restored'
ls -la ${_script_dir}/backups/${_old_backup}.v* || exit 1
echo -n "Attetion ${USER} do you wish to keep current firewall rules active? # "
read -t 120 _user_yn_keep_current
case ${_user_yn_keep_current:-no} in
yes|Yes|Y|y)
	iptables-save > ${_script_dir}/backups/new_firewall.v4
	if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
		ip6tables-save > ${_script_dir}/backups/new_firewall.v6
	fi
	echo "Exiting cleanly now."
	exit 0
;;
no|NO|No|n|N|*)
	echo "Exiting dirty ... restoring backups..."
	if [ -f ${_script_dir}/backups/${_old_backup}.v4 ] && [ -f ${_script_dir}/backups/${_old_backup}.v6 ]; then
		iptables-restore < ${_script_dir}/backups/${_old_backup}.v4
		if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
			ip6tables-restore < ${_script_dir}/backups/${_old_backup}.v6
		fi
		exit 1
	else
		echo "Error ${_script_name} could not find backups of old rules!"
		echo "Flushing everything and restoring Linux defaults"
		echo "This may leave your system insecure so known web services will also be stopped!"
		iptables -P INPUT ACCEPT
		iptables -P FORWARD ACCEPT
		iptables -P OUTPUT ACCEPT
		iptables -t nat -P PREROUTING ACCEPT
		iptables -t nat -P POSTROUTING ACCEPT
		iptables -t nat -P OUTPUT ACCEPT
		iptables -t mangle -P PREROUTING ACCEPT
		iptables -t mangle -P OUTPUT ACCEPT
		iptables -F
		iptables -X
		iptables -t nat -F
		iptables -t nat -X
		iptables -t mangle -F
		iptables -t mangle -X
		if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
			ip6tables -P INPUT ACCEPT
			ip6tables -P FORWARD ACCEPT
			ip6tables -P OUTPUT ACCEPT
#			ip6tables -t nat -P PREROUTING ACCEPT
#			ip6tables -t nat -P POSTROUTING ACCEPT
#			ip6tables -t nat -P OUTPUT ACCEPT
			ip6tables -t mangle -P PREROUTING ACCEPT
			ip6tables -t mangle -P OUTPUT ACCEPT
			ip6tables -F
			ip6tables -X
#			ip6tables -t nat -F
#			ip6tables -t nat -X
			ip6tables -t mangle -F
			ip6tables -t mangle -X
		fi
		exit 2
	fi
;;
esac
