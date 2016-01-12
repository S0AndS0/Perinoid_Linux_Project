Arg_checker(){
	## Print help and log errors example 1
	#	<command_to_test> || Arg_checker --help='<function_name>' --exit='# [<command_to_test>] # Failed'
	## Print help and log errors example 2
	_script_args="${@:---help='Arg_checker' --exit='# [Arg_checker] # Failed to recieve any arguments'}"
	if [ "${#_script_args}" -gt "0" ]; then
		echo "## Notice [Arg_checker] parsing general arguments and setting thier variables..."
		for _KEY in ${_script_args}; do
			case "${_prefix}${_KEY}" in
				-A=*|--apps-list=*)			_key="-A" ;		_value="${_KEY#*=}" ;;
				-AT=*|--apt-target=*)			_key="-AT" ;		_value="${_KEY#*=}" ;;
				-AY=*|--apt-yes=*)			_key="-AY" ;		_value="${_KEY#*=}" ;;
				-ABipv4=*|--add-bridge-ipv4=*)		_key="-ABipv4" ;	_value="${_KEY#*=}" ;;
				-ABipv6=*|--add-bridge-ipv6=*)		_key="-ABipv4" ;	_value="${_KEY#*=}" ;;
				-ABf=*|--add-bridge-finger=*)		_key="-ABf" ;		_value="${_KEY#*=}" ;;
				-ABt=*|--add-bridge-type=*)		_key="-ABt" ;		_value="${_KEY#*=}" ;;
				-ABp=*|--add-bridge-port=*)		_key="-ABp" ;		_value="${_KEY#*=}" ;;
				-B=*|--bridge-nickname=*)		_key="-B" ;		_value="${_KEY#*=}" ;;
				-BA=*|--btc-address=*)			_key="-BA" ;		_value="${_KEY#*=}" ;;
				-B9D=*|--bind9-dir=*)			_key="-B9D" ;		_value="${_KEY#*=}" ;;
				-B9U=*|--bind9-user=*)			_key="-B9U" ;		_value="${_KEY#*=}" ;;
				-B9ipv4=*|--bind9-ipv4=*)		_key="-B9ipv4" ;	_value="${_KEY#*=}" ;;
				-B9P=*|--bind9-portr=*)			_key="-B9P" ;		_value="${_KEY#*=}" ;;
				-C=*|--connections=*)			_key="-C" ;		_value="${_KEY#*=}" ;;
				-E=*|--exit-nickname=*)			_key="-E" ;		_value="${_KEY#*=}" ;;
				-EA=*|--email-address=*)		_key="-EA" ;		_value="${_KEY#*=}" ;;
				-Eipv4=*|--external-ipv4=*)		_key="-Eipv4" ;		_value="${_KEY#*=}" ;;
				-Eipv6=*|--external-ipv6=*)		_key="-Eipv6" ;		_value="${_KEY#*=}" ;;
				-ep=*|--external-parse=*)		_key="-ep" ;		_value="${_KEY#*=}" ;;
				-ex=*|--exit=*)				_key="-ex" ;		_value="${_KEY#*=}" ;;
				-FD=*|--firejail-dir=*)			_key="-FD" ;		_value="${_KEY#*=}" ;;
				-FSN=*|--firejail-service-name=*)	_key="-FSN" ;		_value="${_KEY#*=}" ;;
				-FBI=*|--firejail-bridge-interface=*)	_key="-FBI" ;		_value="${_KEY#*=}" ;;
				-FBF=*|--firejail-bridge-forward=*)	_key="-FBF" ;		_value="${_KEY#*=}" ;;
				-FHI=*|--firejail-host-interface=*)	_key="-FHI" ;		_value="${_KEY#*=}" ;;
				-FBipv4=*|--firejail-bridge-ipv4=*)	_key="-FBipv4" ;	_value="${_KEY#*=}" ;;
				-FNipv4=*|--firejail-nat-ipv4=*)	_key="-FNipv4" ;	_value="${_KEY#*=}" ;;
				-HAC=*|--hidden-auth-cookie=*)		_key="-HAC" ;		_value="${_KEY#*=}" ;;
				-h=*|--help=*)				_key="-H" ;		_value="${_KEY#*=}" ;;
				-h|--help)				_key="-h" ;		_value="${_KEY#*=}" ;;
				-I=*|--install=*)			_key="-I" ;		_value="${_KEY#*=}" ;;
				-ipv6=*|--enable-ipv6=*)		_key="-ipv6" ;		_value="${_KEY#*=}" ;;
				-Lipv4=*|--local-ipv4=*)		_key="-Lipv4" ;		_value="${_KEY#*=}" ;;
				-Lipv6=*|--local-ipv6=*)		_key="-Lipv6" ;		_value="${_KEY#*=}" ;;
				-ND=*|--nginx-dir=*)			_key="-ND" ;		_value="${_KEY#*=}" ;;
				-NHP=*|--nginx-http_port=*)		_key="-NHP" ;		_value="${_KEY#*=}" ;;
				-NI=*|--nginx-index=*)			_key="-NI" ;		_value="${_KEY#*=}" ;;
				-NSN=*|--nginx-sevice-name=*)		_key="-NSN" ;		_value="${_KEY#*=}" ;;
				-NSP=*|--nginx-ssl-port=*)		_key="-NSP" ;		_value="${_KEY#*=}" ;;
				-NU=*|--nginx-url=*)			_key="-NU" ;		_value="${_KEY#*=}" ;;
				-OSP=*|--openssh-port=*)		_key="-OSP" ;		_value="${_KEY#*=}" ;;
				-p=*|--passwd=*)			_key="-p" ;		_value="${_KEY#*=}" ;;
				-PD=*|--privoxy-dir=*)			_key="-PD" ;		_value="${_KEY#*=}" ;;
				-PU=*|--privoxy-user=*)			_key="-PU" ;		_value="${_KEY#*=}" ;;
				-PoD=*|--polipo-dir=*)			_key="-PoD" ;		_value="${_KEY#*=}" ;;
				-PoU=*|--polipo-userr=*)		_key="-PoU" ;		_value="${_KEY#*=}" ;;
				-R=*|--relay-nickname=*)		_key="-R" ;		_value="${_KEY#*=}" ;;
				-Rbr=*|--relay-bandwidth-rate=*)	_key="-Rbr" ;		_value="${_KEY#*=}" ;;
				-Rbb=*|--relay-bandwidth-burst=*)	_key="-Rbb" ;		_value="${_KEY#*=}" ;;
				-SHN=*|--ssh-host-name=*)		_key="-SHN" ;		_value="${_KEY#*=}" ;;
				-SHD=*|--ssh-host-domain=*)		_key="-SHD" ;		_value="${_KEY#*=}" ;;
				-SqD=*|--squid-dir=*)			_key="-SqD" ;		_value="${_KEY#*=}" ;;
				-SqU=*|--squid-user=*)			_key="-SqU" ;		_value="${_KEY#*=}" ;;
				-T=*|--tor-node-types=*)		_key="-T" ;		_value="${_KEY#*=}" ;;
				-TBT=*|--tor-bridge-types=*)		_key="-TBT" ;		_value="${_KEY#*=}" ;;
				-TCT=*|--tor-client-types=*)		_key="-TCT" ;		_value="${_KEY#*=}" ;;
				-TET=*|--tor-exit-types=*)		_key="-TET" ;		_value="${_KEY#*=}" ;;
				-TRT=*|--tor-relay-types=*)		_key="-TRT" ;		_value="${_KEY#*=}" ;;
				-TST=*|--tor-service-types=*)		_key="-TST" ;		_value="${_KEY#*=}" ;;
				-TD=*|--tor-directory=*)		_key="-TD" ;		_value="${_KEY#*=}" ;;
				-TSP=*|--tor-ssh-port=*)		_key="-TSP" ;		_value="${_KEY#*=}" ;;
				-TSC=*|--tor-service-client=*)		_key="-TSC" ;		_value="${_KEY#*=}" ;;
				-TWP=*|--tor-web-port=*)		_key="-TWP" ;		_value="${_KEY#*=}" ;;
				-TOP=*|--tor-or-port=*)			_key="-TOP" ;		_value="${_KEY#*=}" ;;
				-t=*|--temp-directory=*)		_key="-t" ;		_value="${_KEY#*=}" ;;
				-TU=*|--tor-user=*)			_key="-TU" ;		_value="${_KEY#*=}" ;;
				-vf=*|--var-file=*)			_key="-vf" ;		_value="${_KEY#*=}" ;;
				-W=*|--web-directory=*)			_key="-W" ;		_value="${_KEY#*=}" ;;
			esac
			case $_key in
				-A)
					_prefix="" ; _key=""
					_application_list="${_value}"
				;;
				-AT)
					_prefix="" ; _key=""
					_apt_target_release="${_value}"
				;;
				-AY)
					_prefix="" ; _key=""
					_auto_yn="${_value}"
				;;
				-ABipv4)
					_prefix="" ; _key=""
					_bridge_ipv4_to_add="${_value}"
				;;
				-ABipv6)
					_prefix="" ; _key=""
					_bridge_ipv6_to_add="${_value}"
				;;
				-ABf)
					_prefix="" ; _key=""
					_bridge_finger_print_to_add="${_value}"
				;;
				-ABt)
					_prefix="" ; _key=""
					_bridge_type_to_add="${_value}"
				;;
				-ABp)
					_prefix="" ; _key=""
					_bridge_port_to_add="${_value}"
				;;
				-B)
					_prefix="" ; _key=""
					_tor_bridge_nickname="${_value}"
				;;
				-BA)
					_prefix="" ; _key=""
					_btc_address="${_value}"
				;;
				-B9D)
					_prefix="" ; _key=""
					_bind9_dir="${_value}"
				;;
				-B9U)
					_prefix="" ; _key=""
					_bind9_user="${_value}"
				;;
				-B9ipv4)
					_prefix="" ; _key=""
					_bind9_ipv4="${_value}"
				;;
				-B9P)
					_prefix="" ; _key=""
					_bind9_port="${_value}"
				;;
				-C)
					_prefix="" ; _key=""
					_connection_count="${_value}"
				;;
				-E)
					_prefix="" ; _key=""
					_tor_exit_nickname="${_value}"
				;;
				-EA)
					_prefix="" ; _key=""
					_email_address="${_value}"
				;;
				-ep)
					_prefix="" ; _key=""
					_external_parse="${_value}"
				;;
				-ex)
					_prefix="" ; _key=""
					_exit="${_value}"
				;;
				-FD)
					_prefix="" ; _key=""
					_firejail_dir="${_value}"
				;;
				-FSN)
					_prefix="" ; _key=""
					_firejail_service_name="${_value}"
				;;
				-FBI)
					_prefix="" ; _key=""
					_firejail_bridge_interface="${_value}"
				;;
				-FBF)
					_prefix="" ; _key=""
					_firejail_bridge_forward="${_value}"
				;;
				-FHI)
					_prefix="" ; _key=""
					_firejail_host_interface="${_value}"
				;;
				-FBipv4)
					_prefix="" ; _key=""
					_firejail_bridge_ipv4="${_value}"
				;;
				-FNipv4)
					_prefix="" ; _key=""
					_firejail_nat_ipv4="${_value}"
				;;
				-HAC)
					_prefix="" ; _key=""
					_hidden_auth_cookie="${_value}"
				;;
				-H)
					_prefix="" ; _key=""
					_help_args="${_value}"
				;;
				-h)
					_prefix="" ; _key=""
					_help_args="${_script_name},Arg_checker_tor"
				;;
				-I)
					_prefix="" ; _key=""
					_install_method="${_value}"
				;;
				-Eipv4)
					_prefix="" ; _key=""
					_external_ipv4="${_value}"
				;;
				-Eipv6)
					_prefix="" ; _key=""
					_external_ipv6="${_value}"
				;;
				-ipv6)
					_prefix="" ; _key=""
					_enable_ipv6="${_value}"
				;;
				-Lipv4)
					_prefix="" ; _key=""
					_nat_ipv4="${_value}"
				;;
				-Lipv6)
					_prefix="" ; _key=""
					_nat_ipv6="${_value}"
				;;
				-ND)
					_prefix="" ; _key=""
					_nginx_dir="${_value}"
				;;
				-NI)
					_prefix="" ; _key=""
					_nginx_index="${_value}"
				;;
				-NHP)
					_prefix="" ; _key=""
					_nginx_http_port="${_value}"
				;;
				-NSN)
					_prefix="" ; _key=""
					_nginx_service_name="${_value}"
				;;
				-NSP)
					_prefix="" ; _key=""
					_nginx_ssl_port="${_value}"
				;;
				-NU)
					_prefix="" ; _key=""
					_nginx_url="${_value}"
				;;
				-OSP)
					_prefix="" ; _key=""
					_openssh_port="${_value}"
				;;
				-p)
					_prefix="" ; _key=""
					_passwd="${_value}"
				;;
				-PD)
					_prefix="" ; _key=""
					_privoxy_dir="${_value}"
				;;
				-PU)
					_prefix="" ; _key=""
					_privoxy_user="${_value}"
				;;
				-PoD)
					_prefix="" ; _key=""
					_polipo_dir="${_value}"
				;;
				-PoU)
					_prefix="" ; _key=""
					_polipo_user="${_value}"
				;;
				-R)
					_prefix="" ; _key=""
					_tor_relay_nickname="${_value}"
				;;
				-Rbr)
					_prefix="" ; _key=""
					_tor_relay_bandwidth_rate="${_value}"
				;;
				-Rbb)
					_prefix="" ; _key=""
					_tor_relay_bandwidth_burst="${_value}"
				;;
				-SHN)
					_prefix="" ; _key=""
					_ssh_host_name="${_value}"
				;;
				-SHD)
					_prefix="" ; _key=""
					_ssh_host_domain="${_value}"
				;;
				-SqD)
					_prefix="" ; _key=""
					_squid_dir="${_value}"
				;;
				-SqU)
					_prefix="" ; _key=""
					_squid_user="${_value}"
				;;
				-T)
					_prefix="" ; _key=""
					_tor_node_types="${_value}"
				;;
				-TBT)
					_prefix="" ; _key=""
					_bridge_types="${_value},${_bridge_types}"
				;;
				-TCT)
					_prefix="" ; _key=""
					_client_types="${_value},${_client_types}"
				;;
				-TET)
					_prefix="" ; _key=""
					_exit_types="${_value},${_exit_types}"
				;;
				-TRT)
					_prefix="" ; _key=""
					_relay_types="${_value},${_relay_types}"
				;;
				-TST)
					_prefix="" ; _key=""
					_service_types="${_value},${_service_types}"
				;;
				-TD)
					_prefix="" ; _key=""
					_tor_directory="${_value}"
				;;
				-TSC)
					_prefix="" ; _key=""
					_tor_service_clients="${_value}"
				;;
				-TSP)
					_prefix="" ; _key=""
					_tor_ssh_port="${_value}"
				;;
				-TWP)
					_prefix="" ; _key=""
					_tor_web_port="${_value}"
				;;
				-TOP)
					_prefix="" ; _key=""
					_tor_or_port="${_value}"
				;;
				-t)
					_prefix="" ; _key=""
					_temp_dir="${_value}"
				;;
				-TU)
					_prefix="" ; _key=""
					_tor_user="${_value}"
				;;
				-vf)
					_prefix="" ; _key=""
					_var_files="${_value}"
				;;
				-W)
					_prefix="" ; _key=""
					_tor_web_dir="${_value}"
				;;
			esac
		done
#		echo "#	Notice [Arg_checker_tor] parsing spicific arguments and setting thier variables for tor node types selected..."
		for _services in ${_service_types//,/ }; do
			case "${_Types}${_services}" in
				open*)	_Key="_Op" ;	_Value="${_services#*:}" ;;
				auth*)	_Key="_Au" ;	_Value="${_services#*:}" ;;
			esac
			case $_Key in
				_Op)
					_Types="" ; _Key=""
					_open_services="${_Value#*:},${_open_services}"
				;;
				_Au)
					_Types="" ; _Key=""
					_auth_services="${_Value#*:},${_auth_services}"
				;;
			esac
		done
		echo "#	Notice [Arg_checker] parsing spicific arguments for any [-h=...] values"
		if [ "${#_help_args}" != "0" ]; then
			Parse_help "${_help_args}" "${_exit:-0}"
		fi
## Check for presance of [-vf] value and load befor further processing any variables
#	assigned within, note this maybe used to over-write exsisting values
		if [ "${_external_parse}" = "${_script_name}" ]; then
			echo "#	Notice [Arg_checker] parsing spicific arguments for any [-vf=...] values"
		fi
		if [ "${#_var_files}" != "0" ]; then
			if [ "${_external_parse}" = "${_script_name}" ]; then
				echo "#	Notice : [-vf] option detected, parsing aguments from [${_var_files//,/] and [}] file(s)."
			fi
			Parse_varfile_load "${_var_files}"
		fi
		if [ "${#_external_ipv4}" = "0" ]; then
			echo '## Warning [Arg_checker] function detected no [-ip] argument passed, nore was this value set via [-vf] argument.'
			echo "#	if using [${_script_name}] for client only installation you may feed fauls vales, ei [-ip=1.1.1.1]"
			echo "#	however, if using [${_script_name}] for any other perpious you may press [Enter] when promted"
			echo '#	to have this value automaticly assigned for you via a request to [opendns.com] during run-time'
			echo ''
			echo '# Press [Ctrl^c] to quit now, or [Enter] to auto-assigne, or [your-ip] if known to assigne now...'
			echo '#	Your choise...? ~: '
			read _read_external_ipv4
			if [ "${#_read_external_ipv4}" != "0" ]; then
				echo "#	Setting [${_read_external_ipv4}] to [\${_external_ipv4}] variable and continueing..."
				_external_ipv4="${_read_external_ipv4}"
			fi
		fi
		if [ "${_external_parse}" = "${_script_name}" ]; then
			echo "#	Beguinning tor installation process for [${_script_name}], this may take more"
			echo "#	than a minuet, please [${USER}] be present and pashent..."
		elif [ "${_external_parse}" != "${_script_name}" ]; then
			_arg_check_count="$((${_arg_check_count:0}+1))"
			echo "## Notice #${_arg_check_count} [${_external_parse}] : finished reading arguments"
			echo "#	with function [Arg_checker] continuing processing [${_script_name}] for [${USER}]..."
		fi
	elif [ "${#_script_args}" = "0" ]; then
		echo '## Error [Arg_checker] function reading arguments!'
		echo "#	Was [${_script_name}] script given any arguments?"
		echo "#	Try [ ${_script_name} --help ] to start learning about [${_script_name}]"
		echo "#	or [ ${_script_name} --h=\"function_name\" ] to learn about spicific functions"
		exit 1
	fi
}
### Arg_checker_help arg_checker_help arg_checker.sh
#	File:	${_script_dir}/functions/shared/arg_checker.sh
#	Notes:	Full list of arguments, variables and thier default value maybe found via the following command
#		${_script_name} -h='blank_vars'
#	Attention script modders: to incorperate fully such that your custom function makes use of this
#	function use the following example
#		Arg_checker="${@:---help='function_name' --exit='# [function_name] # Failed message'" -ep='function_name'
#	at the beguining of your custom function such that help documentation and error messages are
#	printed prior to exit if the function was not fead any areguments. Your custom function should
#	be passed arguments if using this method.
#	## Output expected from [Arg_checker] function success
### Notice #5 [function_name] : finished reading arguments"
##	with function [Arg_checker] continuing processing [${_script_name}] for [${USER}]..."
#	## Output expected from [Arg_checker] function failure
### Warning ${USER} [${_script_name}] exiting do to errors encountered
##${_now}# Error [# [function_name] # Failed message] did Not finish, please see related help documentation with [${_script_name} --help=function_name]
#	Alternitively you may enable custom error messages on
#	spicific lines by using this function as well on any line; either already writen or custom functions
#		command to try || Arg_checker --help='function_name' --exit='# [function_name] # Failed command to try'
#	While these are not your only options they are available though [${_script_name}] and used thoughout
#	exsisting functions so do not be supprized to see this kind of code if examining source.

## Example for [Write_tor_init_bridge] function call back to [Arg_checker_tor]
#	Arg_checker "${@:---help}" -ep='Write_tor_init_bridge'
## List of all commands excepted with default values (if reading source defaults are after ":-"
#	and befor trailing "}" you will see this bash shortcut used extencively thoughout [${_script_name}]
#	to avoid issues of no-value being passed.
# -C="${_conncetion_count:-8}" -U="${_tor_user:-debian-tor}" -D="${_tor_directory:-/etc}"
# -I="${_install_method:-aptget}" -T="${_tor_node_type:-client}" -E="${_tor_exit_nickname:-exit}"
# -R="${_tor_relay_nickname:-relay}" -B="${_tor_bridge_nickname:-bridge}" -ip="${_external_ipv4}"
# -LIP="${_nat_ipv4}" -W="${_tor_web_dir}" -ipv6="${_enable_ipv6}" -LIP6"${_nat_ipv6}"
# -t="${_temp_dir:-/tmp}" -PD="${_privoxy_dir:-/etc}"
## List of all commands explained
#	argumets explained
#	-A= | --apps-list=	Default [tor,tor-arm,tor-geoipdb,deb.torproject.org-keyring
#		if [-I=aptget] otherwise if [-I=source] then only tor and related packages
#		will be downloaded and installed if functions are present for listed packages
#		leave it be unless cetain of your actions as this will over-write defaults
#		prior to ${_script_name} run time
#	-ABipv4= | --add-bridge-ipv4=			Optional/extpermental, no default,
#	-ABipv6= | --add-bridge-ipv6=			Optional/extpermental, no default,
#		additionally also requires at least [-ABp] also be set to add basic bridge
#		configuration lines to [client] torrc configuration files
#	-ABp= | --add-bridge-port=			Only required if using [-ABipv4/6]
#		arguments are used. adds bridge port to torrc line; formatting for configuration
#		differances within [client] torrc files
#	-ABf= | --add-bridge-finger=			Optional/experimental, no default,
#		used if adding obsuproxy bridge via [-ABt] option to add finger print to
#		torrc config line for [client] connections.
#	-ABt= | --add-bridge-type=(null|obfs3)		Optional/expermenatal, no default,
#		a point for further expansion as it only understands [obfs3] or not and
#		writes to torrc [client] configuration files based upon that and IPv4/6
#	-C= | --connections=	Total number of Tor connections to prep (2-9) default [8]
#		only used if [-T=client] or contains client [-T=client#bridge] sets up
#		number of available tor connections that maybe load-balaced against.
#	-D= | --directory=	Tor configuration/installation base directory default [/etc]
#		this is also where start/stop scripts will be based from, tor [/etc/tor]
#		and initalization scripts [/etc/init] allowing for installing to exsisting
#		chroot directory from the host system.
#		this may also (likely will be) a different path if using [-I=source] argument
#		such as installing to USB or chroot file paths
#	-E= | --exit-nickname=	Tor exit node nickname (custom_name) default [Exit_Node]
#		only used if [-T=exit] to name [torrc-\${_exit_nickname}] files as well as
#		set [Nickname] value within related files. Note if [-W=/some/path] then Tor
#		exit notice will also be copied there allong with related torrc file having
#		required modifications made to serve these files to those that connect back
#		to your exit node; usually to complaine if not cairfull, however, every
#		refarace to limit complaints has been utilized and new methods are-a-cooken
#	-Eipv4= | --external-ipv4=	System's external IP address, optional, if not provided ${_script_name}
#		will atempt to resolve via request to [opendns.com] servers.
#	-ep= | --external-parse=(1|Function_name)	Internal argument, tells parsing
#		function [Arg_checker_tor] to duble-check veriables before processing each
#		function named via [-ep] argument. Note if [-ep=1] then installer assumes
#		you wish to run from beguining. Modders will likely want to make use of this
#		feature as this allows running spicific portions without re-installing
#	-ex= | --exit=			Internally set exit status for help messages, all are piped through
#		[less] command if activated, requiring user interaction. This allows functions with non-
#		critical errors to not compleatly inturupt installation processes.
#	-h | --help		Display this message
#	-h= | --help=		Display help for named function or functions if seperated by camma, log errors too
#	Print help and log errors example 1
#	#<command_to_test> || Arg_checker --help='<function_name>' --exit='# [<command_to_test>] # Failed'
#	Print help and log errors example 2
#	_script_args="${@:---help='<function_name>' --exit='# [$@] # Failed'}"
#	-Lipv4= | --local-ipv4=(${_nat_ipv4}|your_ipv4)	Host internal IP address, default
#		first non-loopback interface with a live IP address if left un-set.
#	-Lipv6= | --local-ipv6=(${_nat_ipv6}|your_ipv6)	Host internal IP address version 6
#		default is to match first live IPv6 address if not set.
#	-I= | --install=	Installation method (aptget|source) default [aptget]
#	-ipv6= | --enable-ipv6=(yes|no)			Optional/eperimental, Default [no]
#		argument enables or dissables ipv6 options where available.
#	-R= | --relay-nickname=	Tor relay node nickname (custom_name) default [Relay_Node]
#		much like [-T=exit] when [-T=relay] this argument is used to uniquly name
#		your torrc configration file.
#	-T= | --type=		Tor node type (client|relay|exit|bridge) default [client]
## Note [-T=] may also be [-T=client#relay#exit], using [#] marks to add more features
#	Additonally [-T=relay] may also have sub-arguments passed via similar naming conventions
#	for example [-T=client#relay-private#bridge-public,privet#exit-public] and ${_script_name} will try to acomidate
#	-t= | --temp-directory=	Tor source code download directory default [/tmp/tor_source_download]
#	-U= | --user=		Tor user/group to set and run tor services default [debian-tor]
#		useful if well versed in Linux and Tor file permissions, otherwise best to
#		leave as default, un-set, for less errors or set if wise.
#	-vf= | --var-file=	Optinaly load file assigning variable aguments. If your head
#		is achy from all these options you may instead assign any value here or found
#		within either [] or [] files
#	-W= | --web-directory=	Tor mirror and hidden service directory default [/var/www/tor]
## Notice : if [-I=source] then you will want [-D=/usr/local/tor]
#	otherwise if [-I=aptget] then you will want [-D=/etc/tor]
# other arguments are optional and if [-I=aptget] then [-D=] is even optional as this ${_script_name}
#	is just smart enough to set defaults safely set otherwise
## Notice : internal [sudo] usage by ${_script_name} is for your protection and to only elivate
#	permissions where nessisary instead of requesting that every notice written to your terminal
#	or to a log file be left to root level users allone
####
