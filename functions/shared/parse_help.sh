Parse_help(){
	_help_args="${1:-$_help_args}"
	_exit_line="${2:-$_exit}"
	if [ "${#_help_args}" != "0" ]; then
		_search_files_tor=$(grep -E 'source' ${_script_dir}/functions/tor/source_tor_functions.sh | grep -vE '#' | awk '{gsub("\"",""); print $2}' | awk '{gsub("\${_dir}","${_script_dir}"); print $1}')
		_search_files_shared=$(grep -E 'source' ${_script_dir}/functions/shared/source_shared_functions.sh | grep -vE '#' | awk '{gsub("\"",""); print $2}' | awk '{gsub("\${_dir}","${_script_dir}"); print $1}')
		_search_files_privoxy=$(grep -E 'source' ${_script_dir}/functions/privoxy/source_privoxy_functions.sh | grep -vE '#' | awk '{gsub("\"",""); print $2}' | awk '{gsub("\${_dir}","${_script_dir}"); print $1}')
		_search_files_nginx=$(grep -E 'source' ${_script_dir}/functions/nginx/source_nginx_functions.sh | grep -vE '#' | awk '{gsub("\"",""); print $2}' | awk '{gsub("\${_dir}","${_script_dir}"); print $1}')
		_search_files_polipo=$(grep -E 'source' ${_script_dir}/functions/polipo/source_polipo_functions.sh | grep -vE '#' | awk '{gsub("\"",""); print $2}' | awk '{gsub("\${_dir}","${_script_dir}"); print $1}')
		_search_files_squid=$(grep -E 'source' ${_script_dir}/functions/squid/source_squid_functions.sh | grep -vE '#' | awk '{gsub("\"",""); print $2}' | awk '{gsub("\${_dir}","${_script_dir}"); print $1}')
		_search_files_bind=$(grep -E 'source' ${_script_dir}/functions/bind/source_bind_functions.sh | grep -vE '#' | awk '{gsub("\"",""); print $2}' | awk '{gsub("\${_dir}","${_script_dir}"); print $1}')
		_search_files_firejail=$(grep -E 'source' ${_script_dir}/functions/firejail/source_firejail_functions.sh | grep -vE '#' | awk '{gsub("\"",""); print $2}' | awk '{gsub("\${_dir}","${_script_dir}"); print $1}')
		_search_files_firetools=$(grep -E 'source' ${_script_dir}/functions/firetools/source_firetools_functions.sh | grep -vE '#' | awk '{gsub("\"",""); print $2}' | awk '{gsub("\${_dir}","${_script_dir}"); print $1}')
		_search_files="${_search_files_tor},${_search_files_shared},${_search_files_polipo},${_search_files_privoxy},${_search_files_nginx},${_serach_files_squid},${_search_files_bind},${_search_files_firejail},${_search_files_firetools}"
		_line_range='400'
		echo "## Notice [Arg_checker] detected --help=[${_help_args}] searching for"
		echo "#	documentation now within [${_dirs//,/] [}] directories"
		for _files in ${_search_files//,/ }; do
			for _function in ${_help_args//,/ }; do
				_search_term=$(head -n1 <<<$(grep -ioE "${_function}.*" <<<$(ls ${_files})))
				_dir="${_search_term%/*}"
				if [ "${#_search_term}" != "0" ]; then
					if [ -f "${_dir}/${_search_term}" ]; then
						echo "# Help documentation for search term [${_search_term}]"
						echo "#	found under [${_dir}/${_search_term}]"
						grep -A${_line_range:-400} -iE "${_function}_help.*|${_search_term}.*" ${_dir}/${_search_term} | grep -B${_line_range:-400} -E '####' | less
					else
						echo "## Notice [Help_usage_tor] function reports..."
						echo "#	No file found to search for further help under [${_dir}/${_search_term}"
						echo "#	while searching for [${_search_term}]"
					fi
				fi
				_last_function="${_function}"
			done
		done
		echo "#	Finished processing help documentation for [${_help_args//,/ }]"
		if [ "${#_exit_line}" = "0" ]; then
			echo "#	Have a nice day ${USER} [${_script_name}] exiting now..."
			exit 1
		elif [ "${_exit_line}" = "0" ]; then
			echo "# allowing further processing..."
		elif [ "${#_exit_line}" -gt "0" ]; then
			echo "## Warning ${USER} [${_script_name}] exiting do to errors encountered."
			Error_generator "${_temp_dir}/${_script_name}_errors/${_last_function:$_script_name}.log" "#${_now}# Error [${_exit_line:-$_script_name}] did Not finish, please see related help documentation with [${_script_name} --help=${_last_function:-$_script_name}]" '1'
			exit 1
		fi
	fi

}
### Parse_help_help parse_help_help parse_help.sh
#	File:	${_script_dir}/functions/shared/parse_help.sh
#	Usage:	This function is called any time that [-h=...] or[--help=...] has a value by the
#		[Arg_checker] function. In cases that the value assigned to [-h=...] has a value
#		matching one of the available functions, then help documention about that function
#		will be displaid. This function also processes [-ex=...] or [--exit=...] arguments
#		and if those contain non-zero [0] values, then errors are logged through the
#		[Error_generator] function prior to exiting [${_script_name}]
####
