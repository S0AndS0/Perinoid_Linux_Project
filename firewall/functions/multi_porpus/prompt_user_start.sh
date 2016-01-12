Prompt_user_start(){
	echo "${_script_name}"
	echo "${_script_dir}"
	echo -n ""
	read _ui
	if [ "${#_check_ip_set}" != "0" ]; then
		echo "#	Notice ip_set.ko detected"
		${_check_ip_set}
		echo "#	${_script_name} will be running with more advanced features"
	else
		echo "#	Notice ${_script_name} could not find ip_set.ko under /lib/modules/"
		echo '#	some features will not be available do to kernel limitations.'
	fi
	if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
		echo "#	Notice ${_script_name} detected IP v6 for ${_lo_iface} and ${_server_iface}"
		echo "#	${_lo_iface} ${_lo_ipv6}"
		echo "#	${_server_iface} ${_server_ipv6}"
	else
		echo "#	notice ${_script_name} did Not detect IP v6 addresses for ${_lo_iface} and ${_server_iface}"
	fi
}
