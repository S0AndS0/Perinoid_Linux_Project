Write_squid_in_conf(){
	_count="${_connection_count:-8}"
	_path="${_squid_dir:-/etc}/squid"
	Overwrite_config_checker "${_path}/squid-in.conf"
	echo 'acl all src all' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl manager proto cache_object' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl localhost src 127.0.0.1/32' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl to_localhost dst 127.0.0.0/8' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl SSL_ports port 443' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl Safe_ports port 80 # http' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl Safe_ports port 21 # ftp' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl Safe_ports port 443 # https' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl Safe_ports port 70 # gopher' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl Safe_ports port 210 # wais' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl Safe_ports port 1025-65535 # unregistered ports' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl Safe_ports port 280 # http-mgmt' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl Safe_ports port 488 # gss-http' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl Safe_ports port 591 # filemaker' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl Safe_ports port 777 # multiling http' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl Safe_ports port 901 # SWAT' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl purge method PURGE' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl CONNECT method CONNECT' | sudo tee -a ${_path}/squid-in.conf
	echo 'http_access allow manager localhost' | sudo tee -a ${_path}/squid-in.conf
	echo 'http_access deny manager' | sudo tee -a ${_path}/squid-in.conf
	echo 'http_access allow purge localhost' | sudo tee -a ${_path}/squid-in.conf
	echo 'http_access deny purge' | sudo tee -a ${_path}/squid-in.conf
	echo 'http_access deny !Safe_ports' | sudo tee -a ${_path}/squid-in.conf
	echo 'http_access deny CONNECT !SSL_ports' | sudo tee -a ${_path}/squid-in.conf
	echo "acl malware_domains url_regex '/etc/squid/Malware-domains.txt'" | sudo tee -a ${_path}/squid-in.conf
	echo 'http_access deny malware_domains' | sudo tee -a ${_path}/squid-in.conf
	echo 'http_access allow localhost' | sudo tee -a ${_path}/squid-in.conf
	echo 'http_access deny all' | sudo tee -a ${_path}/squid-in.conf
	echo 'icp_access deny all' | sudo tee -a ${_path}/squid-in.conf
	echo 'http_port 3400' | sudo tee -a ${_path}/squid-in.conf
	echo 'icp_port 0' | sudo tee -a ${_path}/squid-in.conf
	echo 'hierarchy_stoplist cgi-bin ?' | sudo tee -a ${_path}/squid-in.conf
	echo 'refresh_pattern ^ftp: 1440 20% 10080' | sudo tee -a ${_path}/squid-in.conf
	echo 'refresh_pattern ^gopher: 1440 0% 1440' | sudo tee -a ${_path}/squid-in.conf
	echo 'refresh_pattern -i (/cgi-bin/|\?) 0 0% 0' | sudo tee -a ${_path}/squid-in.conf
	echo 'refresh_pattern . 0 20% 4320' | sudo tee -a ${_path}/squid-in.conf
	for c in {1..$_count}; do
		if [ "${_count}" = "1" ]; then
			echo "cache_peer localhost parent 8118 0 round-robin no-query" | sudo tee -a ${_path}/squid-in.conf
		if [ "${_count}" -gt "1" ]; then
			echo "cache_peer localhost_$c parent $c8118 0 round-robin no-query" | sudo tee -a ${_path}/squid-in.conf
		fi
	done
	echo 'never_direct allow all' | sudo tee -a ${_path}/squid-in.conf
	echo 'always_direct deny all' | sudo tee -a ${_path}/squid-in.conf
	echo 'acl apache rep_header Server ^Apache' | sudo tee -a ${_path}/squid-in.conf
	echo 'broken_vary_encoding allow apache' | sudo tee -a ${_path}/squid-in.conf
	echo 'forwarded_for off' | sudo tee -a ${_path}/squid-in.conf
	echo 'coredump_dir /var/cache/squid-in' | sudo tee -a ${_path}/squid-in.conf
	echo 'cache_dir ufs /var/cache/squid-in 100 16 256' | sudo tee -a ${_path}/squid-in.conf
	echo 'pid_filename /var/run/squid-in.pid' | sudo tee -a ${_path}/squid-in.conf
	echo 'access_log /var/log/squid/access.squid-in.log' | sudo tee -a ${_path}/squid-in.conf
	echo 'cache_store_log /var/log/squid/store.squid-in.log' | sudo tee -a ${_path}/squid-in.conf
	echo 'cache_log /var/log/squid/cache.squid-in.log' | sudo tee -a ${_path}/squid-in.conf
}
### Write_squid_in_conf_help write_squid_in_conf_help write_squid_in_conf.sh
#	File:	${_script_dir}/functions/squid/squid_configs/write_squid_in_conf.sh
#	Argument	Variable		Default
#	[-C=...]	_connection_count	8
#	[-SqD=...]	_squid_dir		/etc
####
