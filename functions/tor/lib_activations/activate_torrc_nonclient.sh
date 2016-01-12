Activate_torrc_nonclient(){
	_tor_node_user="${1:-debian-tor}"
	_tor_node_name="${2:?}"
	echo "## Activating configs for [torrc-${_tor_node_name}] now."
	echo "#	With lib file path under [/var/lib/tor_${_tor_node_name}]"
	echo "#	if running with [service] option selected then [hostname] will be"
	echo "#	found under [/var/lib/tor_${_tor_node_name}/hidden_service/]"
	sudo install -o ${_tor_user:-debian-tor} -g ${_tor_user:-debian-tor} -m 700 /var/lib/tor_${_tor_node_name:-service} || Arg_checker --help='Activate_torrc_nonclient' --exit='# [sudo install -o ${_tor_user:-debian-tor} -g ${_tor_user:-debian-tor} -m 700 /var/lib/tor_${_tor_node_name}] # Failed'
}
### Activate_torrc_nonclient_help activate_torrc_nonclient_help activate_torrc_nonclient.sh
#	File:	${_script_dir}/tor/functions/activate_services/activate_torrc_nonclient.sh
#	This fuction is only run if [Activate_torrc_configs] function detects the following
#	(bridge) or (exit) or (relay) (service)  within an argument passed via [-T="..."]
#	to [${_script_name}] or even [-T=bridge#client#exit] for multi node setup
#	Other arguments read into this function are [-U="${_tor_user:-debian-tor}"]
#	and [-B="${_tor_bridge_nickname:-bridge}"] to name custom directory path
#	or [-R="${_tor_relay_nickname:-relay}"] or [-E="${_tor_exit_nickname:-exit}"]
#	these are what [Activate_torrc_configs] function passes as this function's
#	second argument.
#	During times of hidden service settup this function's second argument, and directory
#	path changes to one that reflects what type of service(s) desired. For example
#	[-T=service-auth:ssh,auth:web,open:mirror,open:ssh,open:web] are current valid options
#	that upon parsing should refelct file paths such as [/var/lib/tor_open-web]
#	for the publicly web service's [hostsname] file under [hidden_service/] sub-directory
#	among other Tor process spicific (pid) file names.
#	Upon service restart you may find your new [domain.onion] with the following commanad
#	[ cat /var/lib/tor_${_tor_node_name}/hidden_service/hostname ]
#	this should also print out the client autherization "cookie" value if running [auth:ssh]
#	or [auth:web] options.
####
