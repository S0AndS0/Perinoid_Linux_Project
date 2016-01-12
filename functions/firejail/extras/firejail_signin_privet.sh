Firejail_signin_privet(){
	Arg_checker "${@:---help='Firejail_signin_privet' --exit='# [Firejail_signin_privet] # Failed to be read arguments'" -ep='Firejail_signin_privet'
	_bridge_interface="${_firejail_bridge_interface:-br0}"
	_bridge_ipv4="${_firejail_bridge_ipv4:-10.10.20.10}"
	_service="${_firejail_service_name:-nginx}"
	sudo firejail --privet --seccomp --net=${_bridge_interface} --ip=${_bridge_ipv4} "/etc/init.d/rsyslog start; /etc/init.d/${_service} start; sleep inf" &
}
### Firejail_Signin_privet_help firejail_Signin_privet_help firejail_Signin_privet.sh
#	File:	${_script_dir}/functions/firejail/extras/firejail_Signin_privet.sh
#	Argument	Variable			Default
#	[-FBI=...]	_firejail_bridge_interface	br0
#	[-FBipv4=...]	_firejail_bridge_ipv4		10.10.20.10
#	[-FSN=...]	_firejail_service_name		nginx
#	Notes:	This fuction under normal [${_script_name}] run time should be called for any service
#		that should be placed in a firejail "sandbox" for example nginx, to help mitigate
#		damage if a vurnability is exploited.
####
