Write_squid_out_conf(){
	_count="${_connection_count:-8}"
	_path="${_squid_dir:-/etc}/squid"
	Overwrite_config_checker "${_path}/squid-out.conf"
	echo 'acl all src all' | tee -a $_path/squid-out.conf
	echo 'acl manager proto cache_object' | tee -a $_path/squid-out.conf
	echo 'acl localhost src 127.0.0.1/32' | tee -a $_path/squid-out.conf
	echo 'acl to_localhost dst 127.0.0.0/8' | tee -a $_path/squid-out.conf
	for _addr_range in ${_range_ipv4//,/ }
		echo "acl localnet src $_addr_range" | tee -a $_path/squid-out.conf
	do
	echo 'acl SSL_ports port 443' | tee -a $_path/squid-out.conf
	echo 'acl Safe_ports port 80 # http' | tee -a $_path/squid-out.conf
	echo 'acl Safe_ports port 21 # ftp' | tee -a $_path/squid-out.conf
	echo 'acl Safe_ports port 443 # https' | tee -a $_path/squid-out.conf
	echo 'acl Safe_ports port 70 # gopher' | tee -a $_path/squid-out.conf
	echo 'acl Safe_ports port 210 # wais' | tee -a $_path/squid-out.conf
	echo 'acl Safe_ports port 1025-65535 # unregistered ports' | tee -a $_path/squid-out.conf
	echo 'acl Safe_ports port 280 # http-mgmt' | tee -a $_path/squid-out.conf
	echo 'acl Safe_ports port 488 # gss-http' | tee -a $_path/squid-out.conf
	echo 'acl Safe_ports port 591 # filemaker' | tee -a $_path/squid-out.conf
	echo 'acl Safe_ports port 777 # multiling http' | tee -a $_path/squid-out.conf
	echo 'acl Safe_ports port 901 # SWAT' | tee -a $_path/squid-out.conf
	echo 'acl purge method PURGE' | tee -a $_path/squid-out.conf
	echo 'acl CONNECT method CONNECT' | tee -a $_path/squid-out.conf
	echo 'http_access allow manager localhost' | tee -a $_path/squid-out.conf
	echo 'http_access deny manager' | tee -a $_path/squid-out.conf
	echo 'http_access allow purge localhost' | tee -a $_path/squid-out.conf
	echo 'http_access deny purge' | tee -a $_path/squid-out.conf
	echo 'http_access deny !Safe_ports' | tee -a $_path/squid-out.conf
	echo 'http_access allow localnet' | tee -a $_path/squid-out.conf
	echo 'http_access allow localhost' | tee -a $_path/squid-out.conf
	echo 'http_access deny all' | tee -a $_path/squid-out.conf
	echo 'icp_access deny all' | tee -a $_path/squid-out.conf
	echo 'http_port 3128' | tee -a $_path/squid-out.conf
	echo 'icp_port 0' | tee -a $_path/squid-out.conf
	echo 'hierarchy_stoplist cgi-bin ?' | tee -a $_path/squid-out.conf
	echo 'refresh_pattern ^ftp: 1440 20% 10080' | tee -a $_path/squid-out.conf
	echo 'refresh_pattern ^gopher: 1440 0% 1440' | tee -a $_path/squid-out.conf
	echo 'refresh_pattern -i (/cgi-bin/|\?) 0 0% 0' | tee -a $_path/squid-out.conf
	echo 'refresh_pattern . 0 20% 4320' | tee -a $_path/squid-out.conf
	echo 'cache_peer localhost parent 3410 0 round-robin no-query' | tee -a $_path/squid-out.conf
	echo 'never_direct allow all' | tee -a $_path/squid-out.conf
	echo 'always_direct deny all' | tee -a $_path/squid-out.conf
	echo 'acl apache rep_header Server ^Apache' | tee -a $_path/squid-out.conf
	echo 'broken_vary_encoding allow apache' | tee -a $_path/squid-out.conf
	echo 'forwarded_for off' | tee -a $_path/squid-out.conf
	echo 'coredump_dir /var/cache/squid-out' | tee -a $_path/squid-out.conf
	echo 'cache_dir ufs /var/cache/squid-out 100 16 256' | tee -a $_path/squid-out.conf
	echo 'pid_filename /var/run/squid-out.pid' | tee -a $_path/squid-out.conf
	echo 'access_log /var/log/squid/access.squid-out.log' | tee -a $_path/squid-out.conf
	echo 'cache_store_log /var/log/squid/store.squid-out.log' | tee -a $_path/squid-out.conf
	echo 'cache_log /var/log/squid/cache.squid-out.log' | tee -a $_path/squid-out.conf
}
### Write_squid_out_conf_help write_squid_out_conf_help write_squid_out_conf.sh
#	File:	${_script_dir}/functions/squid/squid_configs/write_squid_out_conf.sh
#	Argument	Variable		Default
#	[-C=...]	_connection_count	8
#	[-SqD=...]	_squid_dir		/etc
#	Uses:	
####
