Prompt_user_finish(){
	echo -n "Attetion ${USER} do you wish to keep current firewall rules active? # "
	read -t 120 _user_yn_start_filtering
	case ${_user_yn_start_filtering} in
		yes|Yes|Y)
			echo "## Activating iptables chains"
			iptables -I INPUT -j order_input
			iptables -I OUTPUT -j order_output
			if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
				echo "## Activating ip6tables chains"
				ip6tables -I INPUT order_input_v6
				ip6tables -I OUTPUT order_output_v6
			fi
		;;
		no|No|N|*)
			echo "## Notice ${_script_name} will not activate chain filtering"
			echo '#	to enable filtering at a latter time, run the following commands'
			echo '# iptables -I INPUT -j order_input'
			echo '# iptables -I OUTPUT -j order_output'
			if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
				echo '# ip6tables -I INPUT order_input_v6'
				echo '# ip6tables -I OUTPUT order_output_v6'
			fi
		;;
	esac
	
	echo "Notice ${_script_name} finished writing iptables rules, summery of rules bellow..."
	iptables -S
	if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
	ip6tables -S
	fi
	echo 'To keep these settings you must respond "yes" or backups listed will be restored'
	ls -la ${_script_dir}/backups/${_old_backup}.v* || exit 1
	echo -n "Attetion ${USER} do you wish to keep current firewall rules active? # "
	read -t 120 _user_yn_keep_current
	case ${_user_yn_keep_current:-no} in
	yes|Yes|Y|y)
		iptables-save > ${_script_dir}/backups/new_firewall.v4
		if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
			ip6tables-save > ${_script_dir}/backups/new_firewall.v6
		fi
		echo "Exiting cleanly now."
		exit 0
	;;
	no|NO|No|n|N|*)
		echo "Exiting dirty ... restoring backups..."
		if [ -f ${_script_dir}/backups/${_old_backup}.v4 ] && [ -f ${_script_dir}/backups/${_old_backup}.v6 ]; then
			iptables-restore < ${_script_dir}/backups/${_old_backup}.v4
			if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
				ip6tables-restore < ${_script_dir}/backups/${_old_backup}.v6
			fi
			exit 1
		else
			echo "Error ${_script_name} could not find backups of old rules!"
			echo "Flushing everything and restoring Linux defaults"
			echo "This may leave your system insecure so known web services will also be stopped!"
			iptables -P INPUT ACCEPT
			iptables -P FORWARD ACCEPT
			iptables -P OUTPUT ACCEPT
			iptables -t nat -P PREROUTING ACCEPT
			iptables -t nat -P POSTROUTING ACCEPT
			iptables -t nat -P OUTPUT ACCEPT
			iptables -t mangle -P PREROUTING ACCEPT
			iptables -t mangle -P OUTPUT ACCEPT
			iptables -F
			iptables -X
			iptables -t nat -F
			iptables -t nat -X
			iptables -t mangle -F
			iptables -t mangle -X
			if [ "${#_lo_ipv6}" != "0" ] && [ "${#_server_ipv6}" != "0" ]; then
				ip6tables -P INPUT ACCEPT
				ip6tables -P FORWARD ACCEPT
				ip6tables -P OUTPUT ACCEPT
#			ip6tables -t nat -P PREROUTING ACCEPT
#			ip6tables -t nat -P POSTROUTING ACCEPT
#			ip6tables -t nat -P OUTPUT ACCEPT
				ip6tables -t mangle -P PREROUTING ACCEPT
				ip6tables -t mangle -P OUTPUT ACCEPT
				ip6tables -F
				ip6tables -X
#			ip6tables -t nat -F
#			ip6tables -t nat -X
				ip6tables -t mangle -F
				ip6tables -t mangle -X
			fi
			exit 2
		fi
	;;
	esac
}
