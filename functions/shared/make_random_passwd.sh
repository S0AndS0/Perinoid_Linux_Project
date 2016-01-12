Make_random_passwd(){
	Arg_checker "${@:---help='Make_random_passwd' --exit='# [Make_random_passwd] # Failed to be read arguments'}" -ep='Make_random_passwd'
	if [ "${_passwd}" -gt "7" ]; then
		_gen_pass=$(tr -dc A-Za-z0-9_ < /dev/urandom | head -c${_passwd})
		_pass="${_gen_pass}"
		echo "# [Make_random_passwd] generated [${_pass}] password"
		echo "${_pass}"
	elif [ "${#_passwd}" -gt "7" ]; then
		_pass="${_passwd}"
		echo "# [Make_random_passwd] using [-p=] [${_pass}] password"
		echo "${_pass}"
	fi
}
### Make_random_passwd_help make_random_passwd_help make_random_passwd.sh
#	File:	${_script_dir}/functions/shared/make_random_passwd.sh
#	Argument 	Variable		Default
#	[-p=...]	_passwd			8
#	Notes:	this function accepts words and intigers as argumnts, if intiger is grater than 7
#		then integer is used as charicter length of password to genorate or if words charicter
#		lenght is greater than 7 then those words are used without modification as the password
#		to assigne. This function maybe called withing [${_script_name}] multiple times and by
#		default is automaticly asgined a value greater than 7 during run time.
####
