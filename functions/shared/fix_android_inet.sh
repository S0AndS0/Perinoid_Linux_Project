Fix_android_inet(){
	_service_user_name="${1:-debian-tor}"
	_group_to_append="${2:-aid_inet}"
	_search_group=$(grep "${_group_to_append}" /etc/group)
	if [ "${#_search_group}" != "0" ]; then
		echo "## Notice [Fix_android_inet] found [${_group_to_append}] which should have [${_service_user_name}] user/group added"
		sudo usermod -a -G ${_group_to_append} ${_service_user_name}
	else
		echo "## Notice [Fix_android_inet] did not find a group [${_group_to_append}]."
		echo "#	Ignore this message if not running [${_script_name}] on an Adnroid device that is then running Linux."
	fi
}
### Fix_android_inet_help fix_android_inet_help fix_android_inet.sh
#	File:	${_script_dir}/functions/shared/fix_android_inet.sh
#	Argument	Variable		Default
#	\$1		_service_user_name	tor
#	\$2		_group_to_append	aid_ine
#	Notes:	This function is run by Tor node services installation functions and other
#		scripts that install packages requiring use of binding to network sockets.
#		Generally this is only aplicable for Android chroot Linux users, but maybe
#		usefull for other developers as well.
####
