Add_polipo_user(){
	Arg_checker "${@:---help='Add_polipo_user' --exit='# [Add_polipo_user] # Failed to be read argments'}" -ep='Add_polipo_user'
	getent group ${_polipo_user:-polipo} &>/dev/null || groupadd -g 185 ${_polipo_user}
	getent passwd ${_polipo_user} &>/dev/null || useradd -u 185 -g ${_polipo_user} -d /var/cache/${_polipo_user} -c "Caching web proxy" -s /etc/nologin ${_polipo_user}
	chown -R 185:185 /var/cache/${_polipo_user}
}
### Add_polipo_user_help add_polipo_user_help add_polipo_user.sh
#	File:	${_script_dir}/functions/polipo/extras/add_polipo_user.sh
#	
####
