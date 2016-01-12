Add_bind_user(){
	Arg_checker "${@:---help='Add_bind_user' --exit='# [Add_bind_user] # Failed to be read argments'}" -ep='Add_bind_user'
	getent group ${_bind9_user:-bind} &>/dev/null || groupadd -g 119 ${_bind9_user}
	getent passwd ${_bind9_user} &>/dev/null || useradd -u 119 -g ${_bind9_user} -d /var/cache/${_bind9_user} -c "DNS service" -s /etc/nologin ${_bind9_user}
	chown -R 119:119 /var/cache/${_bind9_user}
}
### Add_bind_user_help add_bind_user_help add_bind_user.sh
#	File:	${_script_dir}/functions/bind/extras/add_bind_user.sh
#	
####
