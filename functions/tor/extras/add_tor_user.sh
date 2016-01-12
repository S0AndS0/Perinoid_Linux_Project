Add_tor_user(){
	Arg_checker "${@:---help='Add_tor_user' exit='# [Add_tor_user] # Failed to be read arguments'}" -ep='Add_tor_user'
	groupadd -g 220 ${_tor_user:-debian-tor}
	useradd -u 220 -g 220 -c "The Onion Router" -d /dev/null -s /bin/fauls ${_tor_user:-debian-tor}
}
### Add_tor_user_help add_tor_user_help add_tor_user.sh
#	File:	${_script_dir}/functions/tor/extras/add_tor_user.sh
#	Argument	Variable		Default
#	[-TU=...]	_tor_user		debian-tor
#	Notes:	This function is only called if [-I=source] and ensures that a new user group
#	without shell is made for Tor services to run under.
####
