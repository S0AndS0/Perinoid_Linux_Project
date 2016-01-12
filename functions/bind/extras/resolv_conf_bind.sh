Resolv_conf_bind(){
	Arg_checker "${@:---help='Resolv_conf_bind' --exit='## Failed to be read arguments'}" -ep='Resolv_conf_bind'
	Overwrite_config_checker "${_bind9_dir:-/etc}/resolv.conf"
	echo "nameserver 127.0.0.1" | tee -a ${_bind9_dir}/resolv.conf
}
### Resolv_conf_bind_help resolv_conf_bind_help resolv_conf_bind.sh
#	File:	${_script_dir}/functions/bind/extras/resolv_conf_bind.sh
#	To-Do:	Set nameserver IP address to [firejail] IP address
####
