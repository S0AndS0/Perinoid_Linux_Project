Write_bind_tor_logging(){
	Arg_checker "${@:---help='Write_bind_tor_logging' --exit='# [Write_bind_tor_logging] # Failed to be read arguments'}" -ep='Write_bind_config'
	_path="${_bind9_dir:-/etc}/bind"
	Overwrite_configs_checker "${_path}/named.conf.tor.logging"
	echo 'logging {' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '	channel default_debug {' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '		file "/dev/null";' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '		severity dynamic;' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '	};' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '	channel default_stderr {' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '		file "/dev/null";' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '		severity dynamic;' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '	};' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '	channel default_syslog {' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '		file "/dev/null";' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '		severity dynamic;' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '	};' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '	channel null {' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '		file "/dev/null";' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '		severity dynamic;' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '	};' | sudo tee -a ${_path}/named.conf.tor.logging
	echo '};' | sudo tee -a ${_path}/named.conf.tor.logging
#	echo '' | sudo tee -a ${_path}/named.conf.tor.logging
}
### Write_bind_tor_logging_help write_bind_tor_logging_help write_bind_tor_logging.sh
#	File:	${_script_dir}/functions/bind/bind_configs/write_bind_tor_logging.sh
#	Argument	Variable		Default
#	[-B9D=...]	_bind9_dir		/etc
#	Notes:	While the settings of the file written by this function is referanced by
#		bind9 DNS server, this will write logs to [/dev/null] ie No Logging
#		will take place.
####
