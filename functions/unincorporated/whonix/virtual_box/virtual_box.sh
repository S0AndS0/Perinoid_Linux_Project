#!/bin/bash
Add_apt_virtualbox(){
	_flave="$1"
	if [ $(grep -oE "vivid|utopic|trusty|raring|quantal|precise|lucid|jessie|wheezy|squeeze" <<<${_flave}) ]; then
		echo "deb http://download.virtualbox.org/virtualbox/debian ${_flave} contrib" | tee -a /etc/apt/sources.d/virtualbox.list
	else
		echo "deb http://download.virtualbox.org/virtualbox/debian jessie contrib" | tee -a /etc/apt/sources.d/virtualbox.list
	fi
	apt-key add oracle_vbox.asc || wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add - 
	apt-get update && apt-get upgrade
	apt-get install dkms
	apt-get install virtualbox-5.0
}
Apply_virtualbox_whonix_security_mods(){
	_gateway_name="${1:-Whonix-Gateway"
	_workstation_name="${2:-Whonix-Workstation}"
	if [ $(which VBoxManage) ]; then
		VBoxManage modifyvm "$_gateway_name" --biossysemtimeoffset -35017
		VBoxManage modifyvm "$_workstation_name" --biossysemtimeoffset +27931
	fi
}
#Add_apt_virtualbox $_dist_id_nice
#Apply_virtualbox_whonix_security_mods "Whonix-Gateway" "Whonix-Workstation"
