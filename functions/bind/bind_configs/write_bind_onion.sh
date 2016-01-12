Write_bind_onion(){
	Arg_checker "${@:---help='Write_bind_onion' --exit='# [Write_bind_onion] # Failed to be read arguments'}" -ep='Write_bind_onion'
	_path="${_bind9_dir:-/etc}/bind"
	OverWrite_configs_checker "${_path}/onion"
	echo '$TTL 3D' | sudo tee -a ${_path}/onion
	echo '@	IN	SDA	ns.linux.bogus. hostmaster.linux.bogus. (' | sudo tee -a ${_path}/onion
	echo '				199802151	; serie, fecha de hoy + serie de hoy #' | sudo tee -a ${_path}/onion
	echo '				8H		; refresco, segundos' | sudo tee -a ${_path}/onion
	echo '				2H		; reintento, segundos' | sudo tee -a ${_path}/onion
	echo '				4W		; expira, segundos' | sudo tee -a ${_path}/onion
	echo '				1D )		; minimo, segundos' | sudo tee -a ${_path}/onion
	echo '			NS	ns		; Direccion Inet del servidor de numbres' | sudo tee -a ${_path}/onion
	echo ';' | sudo tee -a ${_path}/onion
#	echo '' | sudo tee -a ${_path}/onion
}
### Write_bind_onion_help write_bind_onion_help write_bind_onion.sh
#	File:	${_script_dir}/functions/bind/bind_configs/write_bind_onion.sh
#	To-Do:	Translate and or utilize options to provide this one instead of english version if applicable
#		Still requires the following declerations to be used
#	zone "onion" {
#		type master;
#		file "onion";
#	};
#		instead of alternet version.
####
