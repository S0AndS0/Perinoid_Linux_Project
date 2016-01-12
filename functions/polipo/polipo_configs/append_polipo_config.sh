Append_polipo_config(){
	_count="${1:-$_connection_count}"
	_path="${2:-$_polipo_dir}/polipo"
	Overwrite_config_checker "${_path}/config"
	if [ -f /usr/share/doc/tor/README.polipo ]; then
		echo "## Detected recomended settings for polipo from local Tor documentation."
		echo "#	Utilizing these settings as a form of furture proffing $_self..."
		echo "## Torify with polipo settings, read more under /usr/share/doc/tor directory" | sudo tee -a $_path/config
		grep -E "socksParentProxy|socksProxyType|diskCacheRoot" /usr/share/doc/tor/README.polipo | sudo tee -a $_path/config
	elif ! [ -f /usr/share/doc/tor/README.polipo ]; then
		echo "## Torify with polipo settings, read more under /usr/share/doc/tor directory" | sudo tee -a $_path/config
		echo 'socksParentProxy = localhost:9050' | sudo tee -a $_path/config
		echo 'socksProxyType = socks5' | sudo tee -a $_path/config
		echo 'disckCachRoot=' | sudo tee -a $_path/config
	fi
	echo 'censoredHeaders = from,accept-language,x-pad,link' | sudo tee -a $_path/config
	echo 'censorReferer = maybe' | sudo tee -a $_path/config
	echo 'dnsQueryIPv6 = no' | sudo tee -a $_path/config
	for _local_addr_range in ${_nat_ipv4//,/ }; do
		echo "allowedClients = $_local_addr_range" | sudo tee -a $_path/config
	done
	echo 'proxyName = "localhost"' | sudo tee -a $_path/config
	echo 'cacheIsShared = false' | sudo tee -a $_path/config
	echo 'localDocumentRoot = ""' | sudo tee -a $_path/config
	echo 'dissableLocalInterface = true' | sudo tee -a $_path/config
	echo 'dissableConfiguration = true' | sudo tee -a $_path/config
	echo 'disableIndexing = true' | sudo tee -a $_path/config
	echo 'disableServersList = true' | sudo tee -a $_path/config
	echo 'dnsUseGethostbyname = yes' | sudo tee -a $_path/config
	echo 'disableVia = true' | sudo tee -a $_path/config
	echo 'daemonise = true' | sudo tee -a $_path/config
	echo 'maxConnectionAge = 5m' | sudo tee -a $_path/config
	echo 'maxConnectionRequests = 120' | sudo tee -a $_path/config
	echo 'socksPerantProxy = "127.0.0.1:9050"' | sudo tee -a $_path/config
	echo 'socksProxyType = socks5' | sudo tee -a $_path/config
	echo 'serverMaxSlots = 8' | sudo tee -a $_path/config
	echo 'serverSlots = 2' | sudo tee -a $_path/config
	echo 'allowedPorts = 1-65535' | sudo tee -a $_path/config
	echo 'tunnelAllowedPorts = 1-65535' | sudo tee -a $_path/config
	echo 'logFile = /var/log/polipo/polipo.log' | sudo tee -a $_path/config
	echo 'pidFile = /var/run/polipo/polipo.pid' | sudo tee -a $_path/config
	if [ "${_mem_total}" -lt "1024" ]; then
		echo "chunkHighMark = 10241024" | sudo tee -a $_path/config
		echo "objectHighMark = 128" | sudo tee -a $_path/config
	elif [ "${_mem_total}" -gt "1024" ]; then
		if [ "${_mem_total}" -lt "2048" ]; then
			echo "chunkHighMark = 40564056" | sudo tee -a $_path/config
			echo "objectHighMark = 2048" | sudo tee -a $_path/config
		elif [ "${_mem_total}" -gt "2048" ]; then
			echo "chunkHighMark = 67108864" | sudo tee -a $_path/config
			echo "objectHighMark = 16384" | sudo tee -a $_path/config
		fi
	fi
#	echo '' | sudo tee -a $_path/config
#	echo '' | sudo tee -a $_path/config
}
### Append_polipo_config_help append_polipo_config_help append_polipo_config.sh
#	File:	${_script_dir}/functions/polipo/polipo_configs/append_polipo_config.sh
####
