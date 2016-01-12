Error_generator(){
	_message="$1"
	_log_destination="${2:-/tmp/errors/error_generator.log}"
	_log_directory="${_log_destination%*/}"
	_log_directory="${_log_directory:-/tmp/errors}"
	_log_file="${_log_destination##*/}"
	_log_file="${_log_file:-generall_messages.log}"
	_log_dest="${_log_directory}/${_log_file}"
	_exit="${3:-0}"
	_now="$(date)"
	if ! [ -d ${_log_directory} ]; then
		mkdir -p ${_log_directory}
	fi
	if [ "${#_log_dest}" != "0" ]; then
		if ! [ -f ${_log_dest} ]; then
			echo "#${_now}# Logs for [${_log_file}] started." | tee -a ${_log_dest}
		fi
		if [ "${#_message}" != "0"]; then
			echo "#${_now}#${_message}" | tee -a ${_log_dest}
		fi
		if [ "${_exit}" = "0" ]; then
			echo "#${_now}#	exit status not triggured in [Error_generator] function, silently allowing further processng..." >> ${_log_dest}
		elif [ "${#_exit}" -gt "0" ]; then
			echo "# Additionally : ${_exit}" | tee -a ${_log_dest}
			exit 1
		elif [ "${_exit}" != "0" ]; then
			echo "#${_now}# Exit status [${_exit}] did not equal [0] quitting [Error_generator] function" | tee -a ${_log_dest}
			exit 1
		fi
	fi
}
### Error_generator_help error_generator_help error_generator.sh
#	File: ${_script_dir}/functions/shared/error_generator.sh
## Error_generator $1 $2 $3
## Error_generator "## Error message" /tmp/errors/spicific_errors.log 1
## Error_generator "## Error message" /tmp/errors/spicific_errors.log "## Secondery/additional log message"
#	First argument is the message to write to log file, default file [/tmp/errors/error_generator.log]
#	Second argument is full file path to log file, regardless of pre-exsistance.
#	Third argument is both exit status and or additionall message to wrie to log file before exiting
#	if third argument equals [0] then this function will not quit and will instead allow further processing of
#	the calling function. This function also preforms general logging if enabled at script run time.
####
