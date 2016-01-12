Start_service(){
	_service="${1:Error No arguments passed to [Start_service] function}"
	_init_dir="${2:-/etc}"
	echo "## Notice [Start_service] reloading and restarting [${_service}] service"
	sudo service ${_serice} stop || ${_init_dir}/init.d/${_service} stop
	sudo service ${_serice} reload || ${_init_dir}/init.d/${_service} reload
	sudo service ${_serice} restart || ${_init_dir}/init.d/${_service} restart
}
### Start_service_help start_service_help start_service.sh
#	File:	${_script_dir}functions/shared/start_service.sh
#	Argument	Variable		Default
#	$1		_service		
#	$2		_init_dir		/etc
####
