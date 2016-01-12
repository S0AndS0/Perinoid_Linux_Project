Ssh_tor_client_configs(){
	Arg_checker "${@:---help='Ssh_tor_client_configs' --exit='# [Ssh_tor_client_configs] # Failed to be read arguments'" -ep='Ssh_tor_client_configs'
	_ssh_dir="${HOME}/.ssh"
	if [ "${#_ssh_host_name}" != "0" ] && [ "${#_ssh_host_domain}" !="0" ]; then
		if [ -f ${_ssh_dir}/ssh_config ]; then
			echo "## Notice [Ssh_tor_client_configs] function detected old [${_ssh_dir}/ssh_config] file"
			echo "#	Backing it up to [${_ssh_dir}/ssh_config_orig] befor writing/appending"
			sudo cp ${_ssh_dir}/ssh_config ${_ssh_dir}/ssh_config_orig
		fi
		echo "host ${_ssh_host_name}" | sudo tee -a ${_ssh_dir}/ssh_config
		echo "    hostname ${_ssh_host_domain}" | sudo tee -a ${_ssh_dir}/ssh_config
		echo '    proxyCommand ncat --proxy 127.0.0.1:9050 --proxy-type sock5 %h %p' | sudo tee -a ${_ssh_dir}/ssh_config
		if [ "${#_hidden_auth_cookie}" != "0" ]; then
			for _count in {1..$_connection_count}; do
				echo "HidServAuth ${_ssh_host_domain} ${_hidden_auth_cookie}" | sudo tee -a ${_tor_directory:-/etc}/tor/torrc-${_count}
			done
		fi
	else
		echo '## Notice [Ssh_tor_client_configs] did not read any arguments via'
		echo '#	[-SHN="..."] and [-SHD="..."] options, moving on...'
	fi
}
### Ssh_tor_client_configs_help ssh_tor_client_configs_help ssh_tor_client_configs.sh
#	File:	${_script_dir}/functions/tor/extras/ssh_tor_client_configs.sh
#	Argument	Variable		Default
#	[-HAC=...]	_hidden_auth_cookie	
#	[-SHN=...]	_ssh_host_name		
#	[-SHD=...]	_ssh_host_domain	
#	Notes:	Uses arguments fead to [${_script_name}] via [-SHN=...] and [-SHD=...] and [-HAC=...]
#	The [-SHN=...] sets the host value to be written [host \${_ssh_host_name}]
#	which maybe latter used by [${USER}] via [ssh \${_ssh_host_name}] for inisheation
#	of ssh session
#	The [-SHD=...] sets the ~.onion domain name to write [hostname \${_ssh_host_domain}]
#	to ssh_config file
#	If [-HAC=...] has a value then this is used to write to each torrc client configuration
#	file as was set with [-C=...] option the hidden authorization cookie
#	[HidServAuth \${_ssh_host_domain} \${_hidden_auth_cookie}]
####
