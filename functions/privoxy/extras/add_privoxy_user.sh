Add_privoxy_user(){
	Arg_checker "${@:---help='Add_privoxy_user' --exit='# [Add_privoxy_user] # Failed to be read arguments'}" -ep='Add_privoxy_user'
	echo "## Notice [Add_privoxy_user] function now adding [${_privoxy_user}] user/group"
	echo '#	to your system with uid/gid [73]'
	groupadd -g 73 ${_privoxy_user:-privoxy}
	/usr/sbin/useradd -u 73 -g 73 ${_privoxy_dir:-/etc}/privoxy -r -s "/sbin/nologin" ${_privoxy_user:-privoxy}
}
### Add_privoxy_user_help add_privoxy_user_help add_privoxy_user.sh
#	File: ${_script_dir}/fucntions/privoxy/extras/add_privoxy_user.sh
#	Uses aruments [-PD='...'] and [-PU='...'] passed to [${_script_name}]
#	Default [--privoxy-dir="${_privoxy_dir:-/etc}"]
#	Default [--privoxy-user="${_privoxy_user:-privoxy}"]
#	Under normal runtime this function is called by [Order_privoxy_install] only
#	if [-T="client"] and [-A="privoxy"] and [-I="source"] are also detected by
#	[${_script_name}] and is activated just prior to running [Source_privoxy_install]
#	function to setup proper user/group on Debian based Linux distros.
#	Argument	Variable		Default
#	[-PU=...]	_privoxy_user		privoxy
#	[-PD=...]	_privoxy_dir		/etc
####
