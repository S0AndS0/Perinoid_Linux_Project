Write_bind_tor_options(){
	Arg_checker "${@:---help='Write_bind_tor_options' --exit='# [Write_bind_tor_options] # Failed to be read arguments'}" -ep='Write_bind_config'
	_path="${_bind9_dir:-/etc}/bind"
	Overwrite_configs_checker "${_path}/named.conf.tor.options"
	echo 'options {' | sudo tee -a ${_path}/named/conf.tor.options
	echo "	listen-on port ${_bind9_port:-53} { ${_bind9_ipv4:-127.0.0.1}; };" | sudo tee -a ${_path}/named/conf.tor.options
	echo '	listen-onv6 port 53 { ::1; };' | sudo tee -a ${_path}/named/conf.tor.options
	echo '	directory          "/var/named";' | sudo tee -a ${_path}/named/conf.tor.options
	echo '	dump-file          "/var/named/data/cache_dump.db";' | sudo tee -a ${_path}/named/conf.tor.options
	echo '	statistics-file    "/var/named/data/named_stats.txt";' | sudo tee -a ${_path}/named/conf.tor.options
	echo '	memstatistics-file "/var/named/data/named_mem_stats.txt";' | sudo tee -a ${_path}/named/conf.tor.options
	echo '	allow-query        { localhost; };' | sudo tee -a ${_path}/named/conf.tor.options
	echo '	rcursion yes;' | sudo tee -a ${_path}/named/conf.tor.options
	echo '	dnssec-enabled yes;' | sudo tee -a ${_path}/named/conf.tor.options
	echo '	dnssec-validation yes;' | sudo tee -a ${_path}/named/conf.tor.options
	echo '	dnssec-lookaside auto;' | sudo tee -a ${_path}/named/conf.tor.options
	echo "	bindkeys-file \"${_path}/named.iscdlv.key\";" | sudo tee -a ${_path}/named/conf.tor.options
	echo '	max-cache-size 16M;' | sudo tee -a ${_path}/named/conf.tor.options
	echo '};' | sudo tee -a ${_path}/named/conf.tor.options
#	echo '' | sudo tee -a ${_path}/named/conf.tor.options
}
### Write_bind_tor_options_help write_bind_tor_options_help write_bind__tor_options.sh
#	File:	${_script_dir}/functions/bind/bind_configs/write_bind_tor_options.sh
#	Argument	Variable		Default
#	[-B9D=...]	_bind9_dir		/etc
#	[-B9ipv4=...]	_bind9_ipv4		127.0.0.1
#	[-B9P=...]	_bind9_port		53
####
