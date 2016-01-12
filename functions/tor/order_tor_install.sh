Order_tor_install(){
	_install_tor_args="${@:---help='Install_tor' --exit='# [Order_tor_install] # Failed'}"
	Arg_checker "${_install_tor_args:---help='Order_tor_install' --exit='#Passing arguments to [Order_tor_install] # Failed'}" -ep='Order_tor_install'
	case ${_install_method:-safe} in
	aptget|apt-get|safe)
		Aptget_tor_install "${_install_tor_args:---help='Aptget_tor_install' --exit='#Passing arguments to [Aptget_tor_install] # Failed'}"
	;;
	source|experoment)
		Add_tor_user "${_install_tor_args:---help='Add_tor_user' --exit='# [Add_tor_user] # Failed to be read arguments'}"
		Source_tor_install "${_install_tor_args:---help='Source_tor_install' --exit='#Passing arguments to [Source_tor_install] # Failed'}"
	;;
	*)
		echo "## Error : [Order_tor_install] function did Not understand how you want to install tor"
		Arg_checker --help='Order_tor_install,Arg_checker,Aptget_tor_install,Source_tor_install' --exit='#Reading arguments through [Aptget_tor_install] or [Source_tor_install] # Failed'
	;;
	esac
	Selinux_tor_mod
	Fix_android_inet "${_tor_user}" "aid_inet"
	for _tor_nod_type in ${_tor_node_types//#/ }; do
		case ${_tor_node_type} in
		bridge*)
			Torrc_bridge_configs "${_install_tor_args:---help='Torrc_bridge_configs' --exit='# [Torrc_bridge_configs] # Failed to be passed arguments'}"
			Write_tor_init_nonclient "${_tor_directory:-/etc}" "${_tor_user:-debian-tor}" "${_tor_bridge_nickname:-bridge}" "bridge"
			Activate_torrc_nonclient "${_tor_user:-debian-tor}" "${_tor_bridge_nickname:-bridge}"
			Start_service "tor_bridge" "${_tor_directory:-/etc}"
		;;
		client*)
			Torrc_client_configs "${_install_tor_args:---help='Torrc_client_configs' --exit='# [Torrc_client_configs] # Failed to be passed arguments'}"
			Write_tor_init_client "${_install_tor_args:---help='Write_tor_init_client' --exit='# [Write_tor_init_client] # Failed to be read arguments'}"
			Activate_torrc_client "${_install_tor_args:---help='Activate_torrc_client' --exit='# [Activate_torrc_client] # Failed to be read arguments'}"
			Mod_hosts_file "${_install_tor_args:---help='Mod_hosts_file' --exit='#Passing arguments to [Mod_hosts_file] # Failed'}"
			Start_service "tor_client" "${_tor_directory:-/etc}"
		;;
		exit*)
			Torrc_exit_configs "${_install_tor_args:---help='Torrc_exit_configs' --exit='# [Torrc_exit_configs] # Failed to be passed arguments'}"
			Write_tor_init_nonclient "${_tor_directory:-/etc}" "${_tor_user:-debian-tor}" "${_tor_exit_nickname:-exit}" "exit"
			Activate_torrc_nonclient "${_tor_user:-debian-tor}" "${_tor_exit_nickname:-exit}"
			Start_service "tor_exit" "${_tor_directory:-/etc}"
		;;
		relay*)
			Torrc_relay_configs "${_install_tor_args:---help='Torrc_relay_configs' --exit='# [Torrc_relay_configs] # Failed to be passed arguemts'}"
			Write_tor_init_nonclient "${_tor_directory:-/etc}" "${_tor_user:-debian-tor}" "${_tor_relay_nickname:-relay}" "relay"
			Activate_torrc_nonclient "${_tor_user:-debian-tor}" "${_tor_relay_nickname:-relay}"
			Start_service "tor_relay" "${_tor_directory:-/etc}"
		;;
		service*)
			Torrc_service_configs "${_install_tor_args:---help='Torrc_service_configs' --exit='# [Torrc_service_configs] # Failed to be passed arguments'}"
			for _open_service in ${_open_serivces//,/ }; do
				case ${_open_service} in
				web)
					Write_tor_init_nonclient "${_tor_directory:-/etc}" "${_tor_user:-debian-tor}" "open-web" "open_web"
					Activate_torrc_nonclient "${_tor_user:-debian-tor}" "open-web"
					Start_service "tor_open_web" "${_tor_directory:-/etc}"
					Write_nginx_server_block "${_install_tor_args:---help='Write_nginx_server_block' --exit='#Passing arguments to [Write_nginx_sserver_block] Failed'" -ep='Write_nginx_server_block' -NSN='hidden_open_web' -NI='index.html' -NU="$(cat /var/lib/tor_open-web/hidden_service/hostname)"
				;;
				mirror)
					Write_tor_init_nonclient "${_tor_directory:-/etc}" "${_tor_user:-debian-tor}" "open-mirror" "open_mirror"
					Activate_torrc_nonclient "${_tor_user:-debian-tor}" "open-mirror"
					Start_service "tor_open_mirror" "${_tor_directory:-/etc}"
					Write_nginx_server_block "${_install_tor_args:---help='Write_nginx_server_block' --exit='#Passing arguments to [Write_nginx_sserver_block] Failed'" -ep='Write_nginx_server_block' -NSN='hidden_open_mirror' -NI='index.html' -NU="$(cat /var/lib/tor_open-mirror/hidden_service/hostname)"
				;;
				ssh)
					Write_tor_init_nonclient "${_tor_directory:-/etc}" "${_tor_user:-debian-tor}" "open-ssh" "open_ssh"
					Activate_torrc_nonclient "${_tor_user:-debian-tor}" "open-ssh"
					Start_service "tor_open_ssh" "${_tor_directory:-/etc}"
					
				;;
				esac
			done
			for _auth_service in ${_auth_serivces//,/ }; do
				case ${_auth_service} in
				web)
					Write_tor_init_nonclient "${_tor_directory:-/etc}" "${_tor_user:-debian-tor}" "auth-web" "auth_web"
					Activate_torrc_nonclient "${_tor_user:-debian-tor}" "auth-web"
					Start_service "tor_auth_web" "${_tor_directory:-/etc}"
					Write_nginx_server_block "${_install_tor_args:---help='Write_nginx_server_block' --exit='#Passing arguments to [Write_nginx_sserver_block] Failed'" -ep='Write_nginx_server_block' -NSN='hidden_open_auth' -NI='index.html' -NU="$(cat /var/lib/tor_auth-web/hidden_service/hostname)"
				;;
				ssh)
					Write_tor_init_nonclient "${_tor_directory:-/etc}" "${_tor_user:-debian-tor}" "auth-ssh" "auth_ssh"
					Activate_torrc_nonclient "${_tor_user:-debian-tor}" "auth-ssh"
					Start_service "tor_auth_ssh" "${_tor_directory:-/etc}"
					
				;;
				esac
			done
		;;
		esac
	done
}
### Order_tor_install_help order_tor_install_help order_tor_install.sh
#	File: ${_script_dir}/functions/tor/order_tor_install.sh
#	Argument	Variable		Default
#	[-I=...]	_install_method		safe
#	[-T=...]	_tor_node_types		client
#	[-TBT=...]	_bridge_types		
#	[-TCT=...]	_client_types		
#	[-TET=...]	_exit_types		
#	[-TRT=...]	_relay_types		
#	[-TST=...]	_service_types		
#	Notes:	This function also parses internally set variables from [Arg_checker] function that
#		are set by sub-parsing [-T=...] arguments. These internall arguments are founc bellow
#	Argument	Variable		Default
#	[_Au=...]	_auth_services		
#	[_Op=...]	_open_services		
####
