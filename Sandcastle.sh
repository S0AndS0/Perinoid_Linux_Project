#!/bin/bash
#PATH=/bin:/usr/bin:/usr/local/bin ; export PATH
 : ${USER?}
_script_dir="${0%/*}"
_script_name="${0##*/}"
_time=$(date)
_now="${_time:-$(date)}"
_script_args="${@:---help}"
Sandcastle(){
	if [ "${EUID}" != "0" ]; then
		echo "## Notice : [Sandcastle] function reports running [${_script_name}] without root user"
		echo '#	Loading functions now, note you will be prompted latter for your password.'
		echo "do not be allarmed, ${_script_name} uses the [sudo] command internally"
		source "${_script_dir}/functions/shared/source_shared_functions.sh" || echo "#${_now}# Error pulling functions for [${_script_name}] from file path [${_script_dir}/functions/tor/source_tor_functions.sh] ... quiting now, see [/tmp/${_script_name}.log] for any further errors" | tee -a /tmp/$_script_name}.log && exit 1
		echo "#	[${_script_name}] loading [Source_shared_functions] list"
		Source_shared_functions "${_script_dir}" || echo "#${_now}# Error loading functions from [${_script_dir}] quitting see [/tmp/${_script_name}.log] for further errors" | tee -a /tmp/${_script_name}.log && exit 1
		echo "#	[${_script_name}] asigning variables based on arguments provided [${_script_args}]"
		Arg_checker "${_script_args:---help='Arg_checker' --exit='# Script did Not recive arguments #'}" -ep="${_script_name}"
		echo "#	[${_script_name}] asigning variables based on host enviroment with [Check_host_enviroment] function"
		Check_host_enviroment
		echo "#	[${_script_name} asgining un-asgined variables to \"safe\" defaults with [default_variables.sh] file"
		source ${_script_dir}/variables/default_variables.sh
		echo "#	[${_script_name}] saving variables to custom file for [${USER}]"
		Output_variables_file "${_script_args}"
		echo "#	[${_script_name}] parsing what applications to install and or configure"
		for _apps in ${_application_list//,/ }; do
			case ${_apps} in
			nginx)
				source "${_script_dir}/functions/nginx/source_nginx_functions.sh" || Arg_checker --help="${_script_name},source_nginx_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/nginx/source_nginx_functions.sh]"
				Source_nginx_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_nginx_functions" --exit="#${_now}# Error reading functions into [${_script_name}] for [Source_nginx_functions]"
				_application_list="${_application_list:-nginx},nginx-common,nginx-full,libgd3"
				Order_nginx_install "${_script_args}"
				
			;;
			tor)
				source "${_script_dir}/functions/tor/source_tor_functions.sh" || Arg_checker --help="${_script_name},Source_tor_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/tor/source_tor_functions.sh]"
				Source_tor_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_tor_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_tor_functions]"
				_application_list="${_application_list:-tor},tor-arm,tor-geoipdb,deb.torproject.org-keyring"
				Order_tor_install "${_script_args}"
			;;
			privoxy)
				source "${_script_dir}/functions/privoxy/source_privoxy_functions.sh" || Arg_checker --help="${_script_name},Source_privoxy_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/privoxy/source_privoxy_functions.sh]"
				Source_privoxy_functions "${_script_dir}" || Arg_checker --help="${_script_name}," --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_privoxy_functions]"
				_application_list="${_application_list:-privoxy}"
				Order_privoxy_install "${_script_args}"
				
			;;
			polipo)
				source "${_script_dir}/functions/polipo/source_polipo_functions.sh" || Arg_checker --help="${_script_name},Source_polipo_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/polipo/source_polipo_functions.sh]"
				Source_polipo_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_polipo_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_polipo_functions]"
				_application_list="${_application_list:-polipo}"
				Order_polipo_install "${_script_args}"
				
			;;
			squid|squid3)
				source "${_script_dir}/functions/squid/source_squid_functions.sh" || Arg_checker --help="${_script_name},Source_squid_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/squid/source_squid_functions.sh]"
				Source_squid_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_squid_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_squid_functions]"
				_application_list="${_application_list:-squid3}"
				Order_squid_install "${_script_args}"
				
			;;
			bind|bind9)
				source "${_script_dir}/functions/bind/source_bind_functions.sh" || Arg_checker --help="${_script_name},Source_bind_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/bind/source_bind_functions.sh]"
				Source_bind_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_bind_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_bind_functions]"
				_application_list="${_application_list:-bind9},dnsutils"
				Order_bind_install "${_script_args}"
				
			;;
			firejail)
				source "${_script_dir}/functions/firejail/source_firejail_functions.sh" || Arg_checker --help="${_script_name},Source_firejail_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/firejail/source_firejail_functions.sh]"
				Source_firejail_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_firejail_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_firejail_functions]"
				_application_list="${_application_list:-firejail},bridge-utilss"
				Order_firejail_install "${_script_args},debootstrap,bridge-utils"
				
			;;
			firetools)
				source "${_script_dir}/functions/firetools/source_firetools_functions.sh" || Arg_checker --help="${_script_name},Source_firetools_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/firetools/source_firetools_functions.sh]"
				Source_firejail_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_firetools_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_firetools_functions]"
				_application_list="${_application_list:-firetools},gcc,make"
				Order_firetools_install "${_script_args}"
				
			;;
			NULL|null)
				echo "## Notice [${_script_name}] fead 'NULL' to install, assuming [${USER}] wishes"
				echo '#	to load all functions into script run-time...'
				source "${_script_dir}/functions/nginx/source_nginx_functions.sh" || Arg_checker --help="${_script_name},source_nginx_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/nginx/source_nginx_functions.sh]"
				Source_nginx_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_nginx_functions" --exit="#${_now}# Error reading functions into [${_script_name}] for [Source_nginx_functions]"
				source "${_script_dir}/functions/tor/source_tor_functions.sh" || Arg_checker --help="${_script_name},Source_tor_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/tor/source_tor_functions.sh]"
				Source_tor_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_tor_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_tor_functions]"
				source "${_script_dir}/functions/privoxy/source_privoxy_functions.sh" || Arg_checker --help="${_script_name},Source_privoxy_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/privoxy/source_privoxy_functions.sh]"
				Source_privoxy_functions "${_script_dir}" || Arg_checker --help="${_script_name}," --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_privoxy_functions]"
				source "${_script_dir}/functions/polipo/source_polipo_functions.sh" || Arg_checker --help="${_script_name},Source_polipo_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/polipo/source_polipo_functions.sh]"
				Source_polipo_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_polipo_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_polipo_functions]"
				source "${_script_dir}/functions/squid/source_squid_functions.sh" || Arg_checker --help="${_script_name},Source_squid_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/squid/source_squid_functions.sh]"
				Source_squid_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_squid_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_squid_functions]"
				source "${_script_dir}/functions/bind/source_bind_functions.sh" || Arg_checker --help="${_script_name},Source_bind_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/bind/source_bind_functions.sh]"
				Source_bind_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_bind_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_bind_functions]"
				source "${_script_dir}/functions/firejail/source_firejail_functions.sh" || Arg_checker --help="${_script_name},Source_firejail_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/firejail/source_firejail_functions.sh]"
				Source_firejail_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_firejail_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_firejail_functions]"
				source "${_script_dir}/functions/firetools/source_firetools_functions.sh" || Arg_checker --help="${_script_name},Source_firetools_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/firetools/source_firetools_functions.sh]"
				Source_firejail_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_firetools_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_firetools_functions]"
			;;
			ALL)
				echo "## Oh my... [${USER}] wants it all from [${_script_name}]?"
				echo '#	away we go, hold on tight...'
				source "${_script_dir}/functions/nginx/source_nginx_functions.sh" || Arg_checker --help="${_script_name},source_nginx_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/nginx/source_nginx_functions.sh]"
				Source_nginx_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_nginx_functions" --exit="#${_now}# Error reading functions into [${_script_name}] for [Source_nginx_functions]"
				source "${_script_dir}/functions/tor/source_tor_functions.sh" || Arg_checker --help="${_script_name},Source_tor_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/tor/source_tor_functions.sh]"
				Source_tor_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_tor_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_tor_functions]"
				source "${_script_dir}/functions/privoxy/source_privoxy_functions.sh" || Arg_checker --help="${_script_name},Source_privoxy_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/privoxy/source_privoxy_functions.sh]"
				Source_privoxy_functions "${_script_dir}" || Arg_checker --help="${_script_name}," --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_privoxy_functions]"
				source "${_script_dir}/functions/polipo/source_polipo_functions.sh" || Arg_checker --help="${_script_name},Source_polipo_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] from [${_script_dir}/functions/polipo/source_polipo_functions.sh]"
				Source_polipo_functions "${_script_dir}" || Arg_checker --help="${_script_name},Source_polipo_functions" --exit="#${_now}# Error pulling functions into [${_script_name}] for [Source_polipo_functions]"
				_application_list="${_application_list:-nginx},nginx-common,nginx-full,libgd3"
				Order_nginx_install "${_script_args}"
				_application_list="${_application_list:-tor},tor-arm,tor-geoipdb,deb.torproject.org-keyring"
				Order_tor_install "${_script_args}"
				_application_list="${_application_list:-privoxy}"
				Order_privoxy_install "${_script_args}"
				_application_list="${_application_list:-polipo}"
				Order_polipo_install "${_script_args}"

			;;
			*)
				Arg_checker --help="${_script_name}" --exit="# [${_script_name}] # Failed to understand [${_apps}] in [${_application_list}]"
			;;
			esac
		done
	elif [ "${EUID}" = "0" ]; then
		echo "## Error : [ Check_root_sudo_user ] function reports"
		echo "#	running [ ${_script_name} ] with root user permissions"
		echo "#	please re-run after logging in to a sudo level user"
		echo "#	do to the nature of these scripts using sudo internally"
		echo "#	please see [ ${_script_name} -h ] for why root user maynot"
		echo "#	inisheate this script."
		exit 1
	fi
}
Sandcastle "${_script_args---help}"
### Sandcastle_help sandcastle_help Sandcastle.sh
### ${_script_name}_help ${_script_name}
#	File: ${_script_dir}/${_script_name}
#	This function checks whether or not a [root] user or [sudo] was used
#	to inisheate commands, if so errors are thrown and [${_script_name}]
#	exits with status [1] if not then arguments are passed to [Install_tor]
#	function.
####
#Arg_checker --help="${_script_name}," --exit="#${_now}# Error pulling functions into [${_script_name}] from []"
