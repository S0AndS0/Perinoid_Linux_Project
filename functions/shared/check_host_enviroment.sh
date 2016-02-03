Check_host_enviroment(){
	if [ "${#USER}" -o "${#HOME}" = "0" ]; then
		 : ${USER?} ; ${HOME?}
	fi
	if [ "${#_dist_id}" -o "${#_dist_id_like}" = "0" ]; then
		_dist_id=${_dist_id:-$(cat /etc/*-release | grep -v "VERSION" | awk '/ID=/{gsub("="," "); print $2}')}
		_dist_id_like=${_dist_id_like:-$(cat /etc/*-release | grep -v "VERSION" | awk '/ID_LIKE=/{gsub("="," "); print $2}')}
	fi
	if [ "${#_dist_id_nice}" = "0" ]; then
		_dist_id_nice=${_dist_id_nice:-$(cat /etc/*-release | grep -v "VERSION" | awk '/PRETTY_NAME=/{gsub("="," "); gsub("\(",""); gsub("\)"," "); print $5}')}
		if [ "${#_dist_id_nice}" = "0" ]; then
			_dist_id_nice=${_dist_id_nice:-$(cat /etc/*-release | grep -v "VERSION" | awk '/DISTRIB_CODENAME=/{gsub("="," "); print $2}')}
		fi
	fi
	if [ "${#_init_group_name}" = "0" ]; then
		_init_group_name=${_init_group_name:-$(sudo grep -E "inet" /etc/group | awk '{gsub(":"," "); print $1}')}
	fi
	if [ "${#_android_chroot}" = "0" ]; then
		if [ "${_init_group_name}" = "aid_inet" ]; then
			_android_chroot="yes"
		elif [ "${_init_group_name}" != "aid_inet" ]; then
			_android_chroot="no"
		fi
	else
		_android_chroot=${_android_chroot}
	fi
	if [ "${#_mem_total}" -o "${#_mem_used}" -o "${#_mem_free}" = "0" ]; then
		_mem_total=${_mem_total:-$(free -m | awk '/Mem:/{print $2}')}
		_mem_used=${_mem_used:-$(free -m | awk '/Mem:/{print $3}')}
		_mem_free=${_mem_free:-$(free -m | awk '/Mem:/{print $4}')}
	fi
	if [ "${#_accelerated_encryption}" = "0" ]; then
		if [ $(grep -E "aes" /proc/cpuinfo) ]; then
			_accelerated_encryption="yes"
		else
			_accelerated_encryption="no"
		fi
	else
		_accelerated_encryption=${_accelerated_encryption}
	fi
	if [ "${#_external_ipv4}" = "0" ]; then
		_external_ipv4=${_external_ipv4:-$(dig +short myip.opendns.com @resolver1.opendns.com)}
		if [ "${#_external_ipv4}" = "0" ]; then
			_external_ipv4=${_external_ipv4:?Error [Check_host_enviroment] function could Not read \$_external_ipv4 variable}
		fi
	fi
	if [ "${#_nat_ipv4}" -o "${#_range_ipv4}" -o "${#_nat_ipv6}" = "0" ]; then
	_nat_ipv4=${_nat_ipv4:-$(ip addr | awk '/inet/{print $2}' | grep -vE '127' | awk '{gsub("/"," "); print $1}' | head -n1)}
	_range_ipv4=${_range_ipv4:-$(ip addr | awk '/inet/{print $2}' | grep -vE '127' | awk '{gsub("/"," "); print $1}' | head -n1 | awk '{gsub("\."," "); print $1"."$2"."$3".1/24"}')}
	_nat_ipv6=${_nat_ipv6:-$(ip addr | awk '/inet6/{print $2}' | grep -vE '1/128' | awk '{gsub("/"," "); print $1} | head -n1)}
	fi
	if [ "${#_hosts_dir}" = "0" ]; then
		_hosts_dir=${_hosts_dir:-/etc}
	fi
	_lo_iface=$(ip addr show up lo | awk '/1: lo/{gsub(":",""); print $2}')
	_lo_ipv4=$(ip addr show up lo | grep -vE 'inet6' | awk '/inet/{print $2}')
	_lo_ipv6=$(ip addr show up lo | awk '/inet6/{print $2}')
	if [ "${#_tor_socks_bind_address}" = "0" ]; then
		_tor_socks_bind_address="${_lo_ipv4%/*}"
	fi
	if [ "${#_tor_socks_listen_address}" = "0" ]; then
		_tor_socks_listen_address="${_lo_ipv4%/*}"
	fi
	if [ "${_openssh_port}" = "0" ]; then
		_openssh_port=$(grep -vE '#' /etc/ssh/sshd_config | awk '/Port/{print $2}' | head -n1)
	fi
}
### Check_host_enviroment_help check_host_enviroment_help check_host_enviroment.sh
#	File:	${_script_dir}/fuctions/shared/check_host_enviroment.sh
## Set_Host_Vars
## Notes
#	No arguments are processed, if called this function sets the following variable values
#	from the /etc/*-release file and requesting local ip addresses and external ip address
#	Note these variable assignments may look a bit strange as they set themselves with current
#	value if any before attempting to assigne any value, this because any of these values maybe
#	pre-assigned prior to script run time or sometimes via [-vf] command argument passed durring
#	script run time or from calling this function repeaditly. In cases where variabes where pre-
#	assigned by not re-assigning on subsquint calls this speeds up over all script performance.
## Variables explained
#	$_dist_id 		~= the [ID=] value 			ei : raspbian or ...
#	$_dist_id_like 		~= the [ID_LIKE] value			ei : debian or ...
#	$_dist_id_nice		~= the [PRETTY_NAME] value		ei : wheezy or ...
#	$_dist_id_nice		~= the [DISTRIB_CODNAME] value		ei : ...
#	$_inet_group_name	~= the [inet] or [aid_inet] value	ei : inet or aid_inet ...
#	$_android_chroot	~= [yes/no] set by checking above variable
#	$_mem_total		~= the total available RAM		ei : 925
#	$_mem_used		~= the amount of RAM already in use	ei : 910
#	$_mem_free		~= the amount of free RAM not in use 	ei : 15
#	$_external_ipv4		~= your system's genuine external IP	ei : 94.xxx.yy.106
#	$_nat_ipv4		~= your system's local IP address (first listted) minus lo
#				ei [192.168.1.5]
#	$_nat_range_ipv4	~= your system's local IP address (first listed) range
#				 adds [.1/24]the end ie [192.168.1.1/24]
#	$_nat_ipv6		~= your system's local Ip address (first listed) minus lo
#				and minus range, ie [f4:b2:b2:a9:c1:c3]
#	$_hosts_dir
####
