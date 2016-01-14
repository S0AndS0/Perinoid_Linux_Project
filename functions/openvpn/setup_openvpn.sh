#!/bin/bash
Install_openvpn(){
	Install_Apt "openvpn,network-manager-openvpn-gnome"
}
Settup_openvpn_script(){
	_vpn_cred_dir="${1:?Error no dir passed to Settup_openvpn_script function}"
	_vpn_user="${2:?}"
	_vpn_pass="${3:?}"
	
	mkdir -p ${_vpn_cred_dir}
	echo "${_vpn_user}" | tee ${_vpn_cred_dir}/current_credentials
	echo "${_vpn_pass}" | tee -a ${_vpn_cred_dir}/current_credentials

	echo "## Setting universal configs to prevent dns leaks to [${_vpn_cred_dir}/current_credentials]"
	echo "script-security 2" | tee -a ${_vpn_cred_dir}/current_credentials
	echo "up /etc/openvpn/update-resolve-conf" | tee -a ${_vpn_cred_dir}/current_credentials
	echo "down /etc/openvpn/update-resolve-conf" | tee -a ${_vpn_cred_dir}/current_credentials
	
	echo "cd ${_vpn_cred_dir}" | tee ${_vpn_cred_dir}/current_startvpn.sh
	echo "xterm -e \"sudo openvpn --config CHANGEME.ovpn --auth-user-pass current_credentials\"" | tee -a ${_vpn_cred_dir}/current_startvpn.sh
	echo "xterm -e \"echo ATTETION! the VPN has been disconnected or failed. Services are now using your real IP address; sleep 30 \" " | tee -a ${_vpn_cred_dir}/current_startvpn.sh
	chmod +x ${_vpn_cred_dir}/current_credentials
}
