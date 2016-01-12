Parse_varfile_load(){
	_var_files="${1:-$_var_files}"
	if [ "${#_var_files}" != "0" ]; then
		if [ "${_external_parse}" = "${_script_name}" ]; then
			echo "#	Notice : [-vf] option detected, parsing aguments from [${_var_files//,/] and [}] file(s)."
		fi
		for _var_file in ${_var_files//,/ }; do
			if [ -f ${_script_dir}/${_var_file} ]; then
				source ${_script_dir}/${_var_file} || Arg_checker --help="Arg_checker" --exit="# [source ${_script_dir}/${_var_file}] # Failed"
			elif [ -f ${_script_dir}/variables/${_var_file} ]; then
				source ${_script_dir}/variables/${_var_file} || Arg_checker --help="Arg_checker" --exit="# [source ${_script_dir}/variables/${_var_file}] # Failed"
			elif [ -f ${_var_file} ]; then
				source ${_var_file} || Arg_checker --help="Arg_checker" --exit="# [source ${_var_file}] # Failed"
			elif ! [ -f ${_var_file} ]; then
				if ! [ -f ${_script_dir}/${_var_file} ]; then
					if ! [ -f ${_script_dir}/functions/shared/sample_vars/${_var_file} ]; then
						echo "# Error encountered loading [${_var_file}]"
						echo "#	[${_sctipt_name}] also tried [${_script_dir}]"
						echo "#	without any luck. Press [Ctrl^c] to quit or"
						echo -n '#	[Enter] to continue...?: '
						read _user_exit
					fi
				fi
			fi
		done
	else
		if [ "${_external_parse}" = "${_script_name}" ]; then
			echo '#	Notice : [-vf] option not passed, no veriable file to read.'
			echo "#	${_script_name} now using arguments passed"
			echo '#	during run time and "safe" defaults.'
		fi
	fi
}
### Parse_varfile_load_help parse_varfile_load_help parse_varfile_load.sh
#	File:	${_script_dir}/functions/shared/parse_varfile_load.sh
####
