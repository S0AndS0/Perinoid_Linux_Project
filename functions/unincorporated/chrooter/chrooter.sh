#!/bin/bash
#PATH=/bin:/usr/bin:/usr/local/bin ; export PATH
 : ${USER?} ${HOME?}
## find out script name
_self="${0##*/}"
## Find out dir path to ${_self}
_dir="${0%/*}"
_back_dir="${_dir}/backup"
_self_args="$@"
_time=$(date)
_now="${_time}"

Self_Check_Root(){
	## Check if root or sudo
	if [ "${EUID}" != "0" ]; then
		echo "## Error : ${_self} is ment for root and sudo users only"
		echo "#	Press [Ctrl^c] to quit or [Enter] to continue with sudo"
		echo "# Command : ${_self} ${_self_args}"
		read
		sudo bash ${_dir}/${_self} "${_self_args}"
		exit $?
	elif [ "${EUID}" = "0" ]; then
		Load_Functions
		if [ "${#_self_args}" != "0" ]; then
			Usage_Parser "${_self_args}"
			exit $?
		elif [ "${#_self_args}" = "0" ]; then
			echo "## Warn: [${_self}] was run without any argumets selected"
			echo "#	normally we should have exited before ever reaching here"
			echo "# Re-running with prompting enabled..."
#			bash ${_dir}/${_self} "-P"
			exit $?
		fi
	fi
}

Load_Functions(){
	echo "## Loading functions for ${_self} one moment please."
	source ${_dir}/functions/app_linker
	source ${_dir}/functions/run_parced_commands
	source ${_dir}/functions/mirror_options
	source ${_dir}/functions/install_listed
	source ${_dir}/functions/check_file_dir
	source ${_dir}/functions/read_chroot_options
	source ${_dir}/functions/check_host_system
	source ${_dir}/functions/mount_chroot_options
	source ${_dir}/functions/usages
}

if [ "${#_self_args}" -gt "0" ]; then
	Self_Check_Root "${_self_args}"
else
	source ${_dir}/functions/usages
	Help_Usage_Args
	exit $?
fi
