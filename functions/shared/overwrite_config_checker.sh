Overwrite_config_checker(){
	_conf_file="${1:?Error configuration file to check with [Overwrite_config_checker] function was not passed}"
	if [ -f "${_conf_file}" ]; then
		echo "## Notice [Overwrite_config_checker] function detected configuration file at [${_conf_file}]"
		echo "#	Backing it up to [${_conf_file}_orig] befor handing back control to calling function"
		sudo mv ${_conf_file} ${_conf_file}_orig
	else
		echo "## Notice [Overwrite_config_checker] function did Not detect any configuration file at [${_conf_file}]"
	fi
	echo '#	[Overwrite_config_file] Handing control back to calling function now...'
}
### Overwrite_config_checker_help overwrite_config_checker_help overwrite_config_checker.sh
#	File:	${_script_dir}/fuctions/shared/overwrite_config_checker.sh
#	Accepts one argument, full file-path to configuration file, to check if exsistant.
#	If file exsists it is backed up to the same directory under a [..._orig] file name before
#	handing control over to calling function. If no configuration file is detected then
#	control is handed back to calling function after printing messages to ${USER}'s terminal
####
