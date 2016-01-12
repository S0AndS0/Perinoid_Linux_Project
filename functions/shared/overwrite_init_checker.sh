Overwrite_init_checker(){
	_init_dir="${1:-/etc}"
	_service="${2:?Error No service name passed to [Overwrite_init_checker] function}"
	_init_file="${_service}"
	if [ -f "${_init_dir}/init.d/${_init_file}" ]; then
		echo "## Notice [Overwrite_init_checker] ensuring [${_service}] service is stopped"
		sudo service ${_service} stop || sudo ${_init_dir}/init.d/${_init_file} stop
		echo "#	Backing up [${_init_file}] file to [${_init_file}_orig]"
		sudo mv ${_init_dir}/init.d/${_init_file} ${_init_dir}/init.d/${_init_file}_orig
	else
		echo "# No file detected for start/stop of [${_service}] service under [${_init_dir}/init.d/${_init_file}]"
	fi
}
### Overwrite_init_checker_help overwrite_init_checker_help overwrite_init_checker.sh
#	File:	${_script_dir}/functions/shared/overwrite_init_checker.sh
#	This function is called internally by [${_script_name}] to prevent overwriting currently running
#	service's start/stop scripts. If a script file is detected then the related service is stopped
#	and the script is backed up prior to handing control back to calling function.
#	If no script is detected then a message reporting such is printed and controll is handed back
#	to the calling function.
#	First argument is the base directory for start/stop scripts, default [/etc] which expands out
#	internally to [/etc/init.d] for checking if Second argument, the service's name, is present.
####
