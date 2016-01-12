Privoxy_client_configs(){
	Arg_checker "${@:---help='Privoxy_client_configs' --exit='# [Privoxy_client_configs] # Failed to be read arguments'}" -ep='Privoxy_client_configs'
	_privoxy_conf_dir="${_privoxy_dir:-/etc}/privoxy"
	for _privoxy_count in {1..$_connection_count}; do
		echo "## Checking if ${_privoxy_conf_dir}/config-${_privoxy_count} already exsists..."
		Overwrite_config_checker "${_privoxy_conf_dir}/config-${_privoxy_count}"
		if ! [ -f ${_privoxy_conf_dir}/config-${_privoxy_count} ]; then
			echo 'user-manual /usr/share/doc/privoxy/user-manual' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo "confdir ${_privoxy_conf_dir}" | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'actionsfile standard.action' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
#			echo 'actionsfile match-all.action' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'actionsfile default.action' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'actionsfile user.action' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'filterfile default.filter' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'toggle 1' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'enable-remote-toggle 0' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'enable-remote-http-toggle 0' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'enable-edit-actions 0' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'enable-blocks 0' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'buffer-limit 40%' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'forwarded-connect-retries 0' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'accept-intercepted-requests 0' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'allow-cgi-request-crunching 0' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'split-large-forms 0' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'keep-alive-timeout 5' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'socket-timeout 300' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo 'handle-as-empty-doc-returns-ok 1' | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			if [ "${_privoxy_count}" = "1" ]; then
				echo "forward-socks4a	/		127.0.0.1:9050	." | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			elif [ "${_privoxy_count}" -gt "1" ]; then
				echo "forward-socks4a	/		127.0.0.1:9$((${_privoxy_count}-1))50	." | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			fi
			echo "logdir /usr/log/privoxy_1" | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo "listen-address localhost:110${_privoxy_count}0" | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
			echo "listen-address 127.0.0.1:110${_privoxy_count}0" | sudo tee -a ${_privoxy_conf_dir}/config-${_privoxy_count}
		fi
	done
}
### Privoxy_client_configs_help privoxy_client_configs_help privoxy_client_configs.sh
#	File:	${_script_dir}/functions/privoxy/config_privoxy/privoxy_client_configs.sh
#	Utilizes [-C=...] and [-PD=...] arguments passed through [${_script_name}] script to setup
#	the same number of privoxy service configuration files as Torrc client files. This function
#	will normally only fire if [${_script_name}] detects [-T="client"] as one of the opptions
#	passed.
#	Arguemnt	Variable		Default
#	[-C=...]	_connection_count	8
#	[-PD=...]	_privoxy_dir		/etc
#	[-PU=...]	_privoxy_user		privoxy
####
