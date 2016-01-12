Write_bind_tor_zones(){
	Arg_checker "${@:---help='Write_bind_tor_zones' --exit='# [Write_bind_tor_zones] # Failed to be read arguments'}" -ep='Write_bind_tor_zones'
	_path="${_bind9_dir:-/etc}/bind"
	Overwrite_configs_checker "${_path}/named.conf.tor.zones"
	echo "#	Writing [${_bind9_conf_dir}/named.conf.tor.zones] file now..."
	echo 'zone "." IN {' | sudo tee -a ${_path}/named.conf.tor.zones
	echo '	type hint;' | sudo tee -a ${_path}/named.conf.tor.zones
	echo '	file "named.ca";' | sudo tee -a ${_path}/named.conf.tor.zones
	echo '};' | sudo tee -a ${_path}/named.conf.tor.zones
	echo "include \"${_path}/named.rfc1912\"" | sudo tee -a ${_path}/named.conf.tor.zones
	echo 'zone "onion" IN {' | sudo tee -a ${_path}/named.conf.tor.zones
	echo '	type master;' | sudo tee -a ${_path}/named.conf.tor.zones
	echo '	file "named.empty";' | sudo tee -a ${_path}/named.conf.tor.zones
	echo '	allow-update { none; };' | sudo tee -a ${_path}/named.conf.tor.zones
	echo '};' | sudo tee -a ${_path}/named.conf.tor.zones
	echo 'zone "i2p" IN {' | sudo tee -a ${_path}/named.conf.tor.zones
	echo '	type master;' | sudo tee -a ${_path}/named.conf.tor.zones
	echo '	file "named.empty";' | sudo tee -a ${_path}/named.conf.tor.zones
	echo '	allow-update { none; };' | sudo tee -a ${_path}/named.conf.tor.zones
	echo '};' | sudo tee -a ${_path}/named.conf.tor.zones
	## See [${_script_name} --help='Write_bind_onion'] for why this is not currently used
#	echo 'zone "onion" {' | sudo tee -a ${_path}/named.conf.tor.zones
#	echo '	type master;' | sudo tee -a ${_path}/named.conf.tor.zones
#	echo '	file "onion";' | sudo tee -a ${_path}/named.conf.tor.zones
#	echo '};' | sudo tee -a ${_path}/named.conf.tor.zones
#	echo '' | sudo tee -a ${_path}/named.conf.tor.zones
}
### Write_bind_tor_zones_help write_bind_tor_zones_help write_bind_tor_zones.sh
#	File:	${_script_dir}/functions/bind/bind_configs/write_bind_tor_zones.sh
#	Argument	Variable		Default
#	[-B9D=...]	_bind9_dir		/etc
####
