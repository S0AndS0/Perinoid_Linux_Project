#	loopback iface
export _lo_iface=$(ip addr show up lo | awk '/1: lo/{gsub(":",""); print $2}')
#	loopback IPv4 address
export _lo_ipv4=$(ip addr show up lo | grep -vE 'inet6' | awk '/inet/{print $2}')
#	loopback IPv6 address if available
export _lo_ipv6=$(ip addr show up lo | awk '/inet6/{print $2}')
#	First live (non-lo interface) interface to variable
export _server_iface=$(ip addr show up | grep -vE 'link|loopback|inet' | awk '/eth|wlan|ppp/{gsub(":",""); print $2}' | head -n1)
export _bridge_external_iface="${_server_iface}"
export _bridge_internal_iface=${_bridge_internal_iface:-$(ip addr show up | grep -vE 'link|loopback|inet' | awk '/eth|wlan|ppp/{gsub(":",""); print $2}' | head -n2 | tail -n1 | grep -vE "${_server_iface}")}
#	First live (non-lo interface) IP address to variable
#_server_ipv4=$(ip addr show up | grep -vE 'link' | grep -A3 -E 'eth|wlan|ppp' | awk '/inet/{print $2}' | head -n1)
export _server_ipv4=$(ip addr show up ${_server_iface} | grep -vE 'link' | awk '/inet/{gsub("/"," "); print $2}' | head -n1)
#	IPv6 non-lo address if available for server interface
export _server_ipv6=$(ip addr show up ${_server_iface} | awk '/inet6/{print $2}')
#	Second live (non-lo interface) IP address to variable
export _server_ip2v4=$(ip addr show up | grep -vE 'link' | grep -A3 -E 'eth|wlan|ppp' | awk '/inet/{print $2}' | head -n2 | tail -n1)
#	Set with DNS request if not set by user
if [ "${#_external_ipv4}" = "0" ]; then
	if [ -x "$(which dig)" ]; then
		export _external_ipv4=$(dig +short myip.opendns.com @resolver1.opendns.com)
		echo "# Notice external IP set by ${_script_name} by checking opendns.com"
	elif [ -x "$(which wget)" ]; then
		export _external_ipv4=$(wget -q -O - checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
		echo "# Notice external IP set by ${_script_name} by checking opendns.org"
	fi
	export _external_ipv4=${_external_ipv4}
	echo "#	${_external_ipv4}"
fi
export _bridge_ipv4_addr="${_server_ip2v4:-10.10.20.1}"
#	Server broadcast IPv4 address
export _server_ipv4_bcast=$(ip addr show up ${_server_iface} | grep -E "${_server_iface}" | awk '/brd/{print $4}')
#	SSH server port (first one only)
#_ssh_port=$(grep -vE '#' /etc/ssh/sshd_config | awk '/Port/{print $2}' | head -n1)
export _ssh_port=$(grep -vE '#' /etc/ssh/sshd_config | awk '/Port/{print $2}')
#	List of bad addresses to loop through
export _bad_ipv4_addrs="0.0.0.0/8,127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,162.168.0.0/16,224.0.0.0/3"
#	List of TCP service ports
export _tcp_ports_list="${_tcp_ports},${_http_port},${_ssl_port},${_ssh_port}"
#	List of dns servers to allow UDP connections to and from. leave commented
#	to have script use system defaults found in /etc/resolv.conf automaticly
#_dns_addresses="8.8.8.8 8.8.4.4"
#	Following checks if iptables may use "--set" features for filtering packets
#	variable will either contain file paths to kernal modules or nothing at all.
export _check_ip_set=$(find /lib/modules/ -name ip_set.ko)
#	IPv4 icmp types to allow
export _icmpv4_allowed_types="0,3,8,11"
#	IPv6 icmp types to allow
export _icmpv6_allowed_types="1,2,3,4,128,129,130,131,133,134,135,136,141,142,143,148,149,151,152,153"
#	Note above two variables are filtered through flood checks to mitigate abuse both to and
#	from device. Additionally the icmpv6 filter automaticly assignes the following icmp types
#	to only be allowed from loopback; 130,131,132,143,151,152,153 to further restrict attack
#	serface available.
export _name_backup="old_firewall"
export _old_backup="${_name_backup}"
