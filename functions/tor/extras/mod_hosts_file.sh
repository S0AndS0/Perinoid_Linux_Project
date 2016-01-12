Mod_hosts_file(){
	Arg_checker "${@:---help='Mod_hosts_file' --exit='# [Mod_hosts_file] # Failed'}" -ep='Mod_hosts_file'
	_hosts_dir="${_tor_directory:-/etc}"
	Overwrite_config_checker "${_hosts_dir}/hosts"
	for _hosts_count in {1..$_connection_count}; do
		if [ "${_hosts_count}" = "1" ]; then
			echo '127.0.0.1 localhost' | sudo tee ${_hosts_dir}/hosts || Arg_checker --help='Mod_hosts_file' --exit='# [echo "127.0.0.1 localhost" | sudo tee ${_hosts_dir}/hosts] # Failed'
		elif [ "${_hosts_count}" -gt "1" ]; then
			echo "127.0.0.1 localhost_${_hosts_count}" | sudo tee -a ${_hosts_dir}/hosts || Arg_checker --help='Mod_hosts_file' --exit='# [echo "127.0.0.1 localhost_${_hosts_count}" | sudo tee -a ${_hosts_dir}/hosts] # Failed'
		else
			echo "## Error: Mod_hosts_file did NOT count ${_hosts_count}"
			Arg_checker --help='Mod_hosts_file' --exit='# [Mod_hosts_file] could not count [-C=?] # Failed'
		fi
	done
	echo "## Restarting networking services"
	sudo service networking restart || Arg_checker --help='Mod_hosts_file' --exit='# [sudo service networking restart] # Failed'
}
### Mod_hosts_file_help mod_hosts_file_help mod_hosts_file.sh
#	File:	${_script_dir}/functions/tor/extras/mod_hosts_file.sh
#	Argument	Variable		Default
#	[-TD=...]	_tor_directory		/etc
#	[-C=...]	_connection_count	8
#	This function is one of the last called by [Order_tor_install] function and
#	depending on the number passed with [-C=...] to [${_script_name}] script
#	This function will write a new hosts file under the same directory tree
#	as where Tor's exicutables live, ie [/etc/hosts] by default for hosts file
#	and [/etc/tor] for tor's default path. This allows for easier setup if
#	utilizing a chroot jail for varius daemons or for each.
#	If running and installin directly to host's file system this could cause errors
#	if a custom hosts file was already in use, to prevent users from losing such
#	customizations, the original is backed up to the same directory under [hosts_orig]
#	file name. Unfortunetly [${_script_name}] is not quite smart enough to then
#	combined these files but if you so wish try the following
#	[ sudo cat ${_hosts_dir}/hosts_orig >> ${_hosts_dir}/hosts ]
#	to append your custom hosts file to the end of what was witten for tor client
#	services.
####
