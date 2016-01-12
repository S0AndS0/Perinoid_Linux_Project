Source_functions(){
	_base_dir="${1:?Error no \$_base_dir passed to [Source_functions] function}"
	_permissions="${2:--rwxr--r--"
	_key_words="${3:?Error no \$_key_words passed to [Source_functions] function}"
	for _listed in $(ls -l ${_base_dir} | awk '{print $9}'); do
		if [ -d "${_base_dir}/${_listed}" ]; then
			echo "## Notice [Source_functions] found directory [${_listed}] in results"
			case $(grep -Eo "${key_words//,/|}" <<<$(echo "${_file_to_check}")) in
			*${_key_words//,/|}*)
				echo "#	resubmitting [${_base_dir}/${_listed}] for recursive processing"
				echo "#	with search term [${_key_words}"
				Source_functions "${_base_dir}/${_listed}" "${_key_word}"
			;;
			esac
		elif [ -f "${_base_dir}/${_listed}" ]; then
			echo "## Notice [Source_functions] found file in [${_listed}] results"
			_file_to_check="${_base_dir}/${_listed}"
			if [ "${_permissions}" = "$(ls -l ${_file_to_check} | awk '{print $1}')" ]; then
				echo "#	Permissions check is good"
				if [ "sh" -o ".sh" = "${_file_to_check#*.sh}" ]; then
					echo "#	File extention is good"
					case $(grep -Eo "${key_words//,/|}" <<<$(echo "${_file_to_check}")) in
					*${_key_words//,/|}*)
						echo "#	Search terms [${_key_words}] found within file name"
						echo "#	adding [${_file_to_check}] functions"
						echo "#	available to [${_script_name}]"
						source ${_file_to_check}
					;;
					esac
				elif [ "sh" -o ".sh" != "${_file_to_check#*.sh}" ]; then
					echo "#	File extention failed for [${_file_to_check}] file, skipping"
				fi
			elif [ "${_permissions}" != "$(ls -l ${_file_to_check} | awk '{print $1}')" ]; then
				echo "#	Permissions check failed, skipping [${_file_to_check}] file"
			fi
		elif ! [ -d "${_base_dir}/${_listed}" ] && ! [ -f "${_base_dir}/${_listed}" ]; then
			echo "## Error [Source_functions] function fed bad input..."
		fi
	done
}
### Source_functions_help source_functions_help source_functions.sh
#	File: ${_script_dir}/functions/shared/source_functions.sh
#	Positional Argument examples
## Source_functions $1 $2 $3
## Source_functions ${_script_dir}/functions -rwxr--r-- tor
#	Positional Argument explanations
#	First argument is the base directory to beguin searching for files, if a sub-directory is found
#	then that sub-directory will be searched recursivly by re-calling this function.
#	Second argument is what permissions each file should be, ei [-rwxr--r--] allows read access to all
#	but only root may write or exicute.
#	Third argument is the search terms to match file names against, this is done within a case
#	statment to avoid duble-loading of files that match more than one term.
#	This function only loads a file as a function if it has a [.sh] extention and the above arguments
#	criteria are met.
####
