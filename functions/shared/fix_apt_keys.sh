Fix_Apt_Keys(){
	Arg_checker "${@:---help='Fix_Apt_Keys' --exit='# [Fix_Apt_Keys] # Failed to be read arguments'}" -ep='Fix_Apt_Keys'
	apt-get update 2> ${_temp_dir:-/tmp}/keymissing
	for _key in $(grep "NO_PUBKEY" ${_temp_dir:-/tmp}/keymissing | sed "s/.*NO_PUBKEY //"); do
		echo -e "nProcessing key: $_key"
		gpg --keyserver keys.gnupg.net --recv $_key && gpg --export --armor $_key | sudo apt-key add -
	done
	echo "Refreshing apt-get allowed sources"
	sudo apt-get update
}
### Fix_Apt_Keys_help fix_apt_keys_help fix_apt_keys.sh
#	File:	${_script_dir}/functions/shared/fix_apt_keys.sh
#	Argument	Variable		Default
#	[-t=...]	_temp_dir		/tmp
#	Notes: When called this function runs apt-get update and then for each key that shows as missing
#	the keys are downloaded and added to the keyring for apt-get and to wrap-up it runs apt-get
#	update once more.
####
