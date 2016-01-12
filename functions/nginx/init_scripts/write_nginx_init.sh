Write_nginx_init(){
	Arg_checker "${@:---help='Write_nginx_init' --exit='# [Write_nginx_init] Failed to be read arguments'}" -ep='Write_nginx_init'
	Overwrite_config_checker "${_nginx_dir:-/etc}/init.d/nginx"
	
	## Under start, if firejail is installed
#	echo "firejail --caps.keep=chown,net_bind_service,setgid,setuid --seccomp ${_nginx_dir}/init.d/nginx start" | sudo tee -a ${_nginx_dir}/init.d/nginx
	
#	echo "" | sudo tee -a ${_nginx_dir}/init.d/nginx
#	echo '' | sudo tee -a ${_nginx_dir}/init.d/nginx
}
### Write_nginx_init_help write_nginx_init_help write_nginx_init.sh
#	File:	${_script_dir}/functions/nginx/init_scripts/write_nginx_init.sh
####
