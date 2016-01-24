Output_variables_file(){
	_var_name="${1:?}"
	_var_value="${2:?}"
	if [ "${_external_parse}" != "${_script_name}" ] && [ "${_external_parse}" = -o "END" "end" ]; then
		_vars_out_file="${_script_dir}/variables/${USER}_vars.sh"
		Overwrite_config_checker "${_vars_out_file}"
		echo "${_var_name}=${_var_value}" | tee -a ${_vars_out_file}
		## Uncomment to clear value after writing
		#${_var_name}=${_var_value}
	elif [ "${_external_parse}" != "${_script_name}" ] && [ "${_external_parse}" = -o "WRITE" "write" ]; then
		_vars_out_file="${_script_dir}/variables/${USER}_vars.sh"
		echo "${_var_name}=${_var_value}" | tee -a ${_vars_out_file}
	fi
}
### Output_variables_file_help output_variables_file_help output_variables_file.sh
#	This function re-reads variables from [Arg_checker] function and outputs custom variables file
#	for ${USER} these files maybe loaded latter to repeat the same configurations without
#	specifying anything more than [-vf="${_vars_out_file}"]
#	The files written by this function are saved under [${_script_dir}/variables/]
#	directory
#	At this time this function will only output if the [\${_external_parse}] variable contains
#	either "END" or "end" to write a new file with custom variables or "write" to
#	append a variable to an exsisting file.
####
