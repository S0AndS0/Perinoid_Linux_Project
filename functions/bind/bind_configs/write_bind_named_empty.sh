Write_bind_named_empty(){
	Arg_checker "${@:---help='Write_bind_named_empty' --exit='# [Write_bind_named_empty] # Failed to be read arguments'}" -ep='Write_bind_config'
	_path="${_bind9_dir:-/etc}/bind"
	Overwrite_configs_checker "${_path}/named.empty"
	echo '$TTL 3H' | sudo tee -a ${_path}/named.empty
	echo '@	IN SOA	@ rname.invalid. (' | sudo tee -a ${_path}/named.empty
	echo '				0	; serial' | sudo tee -a ${_path}/named.empty
	echo '				1D	; refresh' | sudo tee -a ${_path}/named.empty
	echo '				1H	; retry' | sudo tee -a ${_path}/named.empty
	echo '				1W	; expire' | sudo tee -a ${_path}/named.empty
	echo '				3H )	; minimum' | sudo tee -a ${_path}/named.empty
	echo '	NS	@' | sudo tee -a ${_path}/named.empty
	echo "	A	${_bind9_ipv4:-127.0.0.1}" | sudo tee -a ${_path}/named.empty
	echo '	AAAA	::1' | sudo tee -a ${_path}/named.empty
#	echo '' | sudo tee -a ${_path}/named.empty
}
### Write_bind_named_empty_help write_bind_named_empty_help write_bind_named_empty.sh
#	File:	${_script_dir}/functions/bind/bind_configs/write_bind_named_empty.sh
#	Argument	Variable		Default
#	[-B9D=...]	_bind9_dir		/etc
#	[-B9ipv4=...]	_bind9_ipv4		127.0.0.1
#	Notes:	This function writes a file that is referanced by bind9 DNS server to
#		deny exsistance of domain names such as [~.onion] and [~.i2p] in cases
#		that an application atempts to resolve without the use of socks proxy.
####
