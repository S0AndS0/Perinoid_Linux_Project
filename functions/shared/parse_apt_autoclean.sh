Parse_apt_autoclean(){
	Arg_checker "${@:---help='Parse_apt_autoclean' --exit='# [Parse_apt_autoclean] # Failed to be read arguments'}" -ep='Parse_apt_autoclean'
	sudo apt-get purge $(dpkg -l | awk '/^rc/ { print $2 }')
	sudo apt-get autoremove
}
### Parse_apt_autoclean_help parse_apt_autoclean_help parse_apt_autoclean.sh
#	File:	${_script_dir}/functions/shared/parse_apt_autoclean.sh
####
