Torrc_service_configs(){
	Arg_checker "${@:---help='Torrc_service_configs' --exit='# [Torrc_service_configs] # Failed to be read arguments'}" -ep='Torrc_service_configs'
	_tor_dir="${_tor_directory:-/etc}/tor"
	if [ -f "${_tor_dir}/torrc-service" ]; then
		echo "## Warning [Torrc_service_configs] function detected old [torrc-service] file."
		mv ${_tor_dir}/torrc-service ${_tor_dir}/torrc-service.orig
	fi
	for _open_service in ${_open_services//,/ }; do
		case $_open_service in
		web)
			Overwrite_config_checker "${_tor_directory}/tor/torrc-open-web"
			echo 'ClientOnly 0' | tee -a ${_tor_dir}/torrc-open-web
			echo 'DataDirectory /var/lib/tor_open-web' | tee -a ${_tor_dir}/torrc-open-web
			echo 'HiddenServiceDir /var/lib/tor_open-web/hidden_service/' | tee -a ${_tor_dir}/torrc-open-web
			echo "HiddenServicePort ${_nginx_http_port} ${_tor_hidden_service_addr:-127.0.0.1}:${_tor_web_port}" | tee -a ${_tor_dir}/torrc-open-web
			echo 'ExcludeSingleHopRelays 1' | tee -a ${_tor_dir}/torrc-open-web
		;;
		mirror)
			Overwrite_config_checker "${_tor_directory}/tor/torrc-open-mirror"
			echo 'ClientOnly 0' | tee -a ${_tor_dir}/torrc-open-mirror
			echo 'DataDirectory /var/lib/tor_open-mirror' | tee -a ${_tor_dir}/torrc-open-mirror
			echo 'HiddenServiceDir /var/lib/tor_open-mirror/hidden_service/' | tee -a ${_tor_dir}/torrc-open-mirror
			echo "HiddenServicePort ${_nginx_http_port} ${_tor_hidden_service_addr:-127.0.0.1}:${_tor_web_port}" | tee -a ${_tor_dir}/torrc-open-mirror
			echo 'ExcludeSingleHopRelays 1' | tee -a ${_tor_dir}/torrc-open-mirror
		;;
		ssh)
			Overwrite_config_checker "${_tor_directory}/tor/torrc-open-ssh"
			echo 'ClientOnly 0' | tee -a ${_tor_dir}/torrc-open-ssh
			echo 'DataDirectory /var/lib/tor_open-ssh' | tee -a ${_tor_dir}/torrc-open-ssh
			echo 'HiddenServiceDir /var/lib/tor_open-ssh/hidden_service/' | tee -a ${_tor_dir}/torrc-open-ssh
			echo "HiddenServicePort ${_openssh_port} ${_tor_hidden_service_addr:-127.0.0.1}:${_tor_ssh_port}" | tee -a ${_tor_dir}/torrc-open-ssh
			echo 'ExcludeSingleHopRelays 1' | tee -a ${_tor_dir}/torrc-open-ssh
		;;
		esac
	done
	for _auth_service in ${_auth_services//,/ }; do
		case $_auth_service in
		web)
			Overwrite_config_checker "${_tor_directory}/tor/torrc-auth-web"
			echo 'ClientOnly 0' | tee -a ${_tor_dir}/torrc-auth-web
			echo 'DataDirectory /var/lib/tor_auth-web' | tee -a ${_tor_dir}/torrc-auth-web
			echo 'HiddenServiceDir /var/lib/tor_auth-web/hidden_service/' | tee -a ${_tor_dir}/torrc-auth-web
			echo 'PublishHidServDescriptors 0' | tee -a ${_tor_dir}/torrc-auth-web
			echo "HiddenServiceAuthorizedClient stealth ${_tor_service_clients}" | tee -a ${_tor_dir}/torrc-auth-web
			echo "HiddenServicePort ${_nginx_http_port} 127.0.0.1:${_tor_web_port}" | tee -a ${_tor_dir}/torrc-auth-web
			echo 'ExcludeSingleHopRelays 1' | tee -a ${_tor_dir}/torrc-auth-web
		;;
		ssh)
			Overwrite_config_checker "${_tor_directory}/tor/torrc-auth-ssh"
			echo 'ClientOnly 0' | tee -a ${_tor_dir}/torrc-auth-web
			echo 'DataDirectory /var/lib/tor_auth-ssh' | tee -a ${_tor_dir}/torrc-auth-web
			echo 'HiddenServiceDir /var/lib/tor_auth-ssh/hidden_service/' | tee -a ${_tor_dir}/torrc-auth-web
			echo 'PublishHidServDescriptors 0' | tee -a ${_tor_dir}/torrc-auth-ssh
			echo "HiddenServiceAuthorizedClient stealth ${_tor_service_clients}" | tee -a ${_tor_dir}/torrc-auth-web
			echo "HiddenServicePort ${_openssh_port} 127.0.0.1:${_tor_ssh_port}" | tee -a ${_tor_dir}/torrc-auth-web
			echo 'ExcludeSingleHopRelays 1' | tee -a ${_tor_dir}/torrc-auth-web
		;;
		esac
	done
#echo "" | tee -a ${_tor_dir}/torrc--
#echo "" | tee -a ${_tor_dir}/torrc--
#echo '' | tee -a ${_tor_dir}/torrc--
#sudo service tor restart
#cat /var/lib/tor/hidden_service/hostname
}
###
####
#_auth_services
#_open_services

#DataDirectory /var/lib/tor
#HiddenServiceDir /var/lib/tor/hidden_service/
#HiddenServicePort 80 127.0.0.1:8080
##HiddenServiceAuthorizedClient stealth ${_tor_service_clients}
