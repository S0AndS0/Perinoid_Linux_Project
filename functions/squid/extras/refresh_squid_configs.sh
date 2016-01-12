Refresh_squid_configs(){
	Arg_checker "${@:---help='Refresh_squid_configs' --exit='# [Refresh_squid_configs] # Failed to be read agruments'}" -ep='Refresh_squid_configs'
	echo "## Refreshing squid3 cache for new configurations"
	sudo ${_scuid_dir:-/etc}/init.d/squid3 stop
	sudo squid3 -f ${_squid_dir:-/etc}/squid/squid3.conf -z
	sudo ${_squid_dir:-/etc}/init.d/squid3 start
}
### Refresh_squid_configs_help refresh_squid_configs_help refresh_squid_configs.sh
#	File: ${_script_dir}/functions/squid/extras/refresh_squid_configs.sh
#	Argument	Variable		Defaault
#	[-SqD=...]	_squid_dir		/etc
#	Uses: Stops squid service, then refreshes squid configurations, and starts squid
#		before handing control back to calling function.
####
