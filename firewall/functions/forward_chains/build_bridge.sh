Build_bridge(){
	echo '## Checking forwarding settings'
	if [ "${_make_bridged_forwarding}" = "yes" ]; then
		## Detect if bridging interfaces with bridge-utils
		if [ "${#_bridge_external_iface}" != "0" ] && [ "${#_bridge_internal_iface}" != "0" ]; then
			## Test for bridge-utils and if bridge name does not exsist
			if [ -x $(which bridge-utils) ]; then
				_check_for_bridge_fail=$(brctl show ${_bridge_internal_iface} | grep -E 'No such device')
				if [ "${_check_for_bridge_fail}" = "No such debice" ]; then
					brctl addbr ${_bridge_internal_iface}
					ifconfig ${_bridge_internal_iface} ${_bridge_ipv4_addr}/24
				fi
			fi
		fi
	fi
}
