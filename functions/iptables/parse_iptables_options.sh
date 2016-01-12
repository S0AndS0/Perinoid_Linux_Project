## Example call for Version
#	Version
## Note : This function is a place holder for tracking
#	versions of individual functions
Version(){ echo "## Version : 0.0.1a_${_self}" ; }
Arg_checker_iptables(){
#	STD_IN=0
	## Source of function example
	#	http://stackoverflow.com/a/24121652/2632107
	_prefix=""
	_key=""
	_value=""
	for _KEY in $@; do
		case "${_prefix}${_KEY}" in
			-h*|--help*|-h=*|--help=*)  _key="-h"; _value="${_KEY#*=}";;
			-v*|--version*|-v=*|--version=*)	_key="-v" ;	_value="${_KEY#*=}" ;;
			-LI*|--loc-iface*|-LI=*|--loc-iface=*) 	_key="-LI" ;	_value="${_KEY#*=}" ;;
			-SI*|--srv-iface*|-SI=*|--srv-iface=*)	_key="-SI" ;	_value="${_KEY#*=}" ;;
			-Ch*|--check*|-Ch=*|--check=*)		_key="-Ch" ;	_value="${_KEY#*=}" ;;
			-V=*|--verbose=*|-V*|--verbose*)	_key="-V" ;	_value="${_KEY#*=}" ;;
			*) 					_key="_0" ; 	_value="$_{KEY#*=}" ;;
		esac
		case $_key in
			-h)
				_prefix=""
				_key=""
				Help_Usage_Args
				exit $?
			;;
			-v)
				_prefix=""
				_key=""
				Version
				exit $?
			;;
			-V)
				_prefix=""
				_key=""
				_Out_File=${_value}
				echo "## Output/save file [${_Out_File}]"
				Verbosoty_Parcer ${_Out_File}
			;;
			-Ch)
				_prefix=""
				_key=""
				_Out_File=${_value}
				echo "## Output/save file [${_Out_File}]"
				Load_Checker_Variables ${_Out_File}
			;;
			-LI)
#				_prefix=""
#				_key=""
				echo "##	Usage_Parcer read additional local interfaces : [${_value}]"
				Local_Interface="${_value},${Local_Interface}"
			;;
			-SI)
#				_prefix=""
#				_key=""
				echo "##	Usage_Parcer read additional server interfaces : [${_value}]"
				Server_Interface="${_value},${Server_Interface}"
			;;
			_0)
				_prefix="${_KEY}="
				_key=""
				Help_Usage_Args "${_prefix}${_value}"
				exit 2
			;;
		esac
	done
	## If not exited, then run default args with any additions if any
#	Parce_Ifaces_toAddr "${Server_Interface},${Local_Interface}" "${Server_Interface}" "${Local_Interface}"
}

## Example call for Verbosoty_Parcer
#	Verbosoty_Parcer /some/file
Verbosoty_Parcer(){
	Out_File_Parcer "$1"
	IPTv4="echo /sbin/iptables"
	IPTSv4="echo /sbin/iptables-save"
	IPTRv4="echo /sbin/iptables-restore"
	IPTv6="echo /sbin/ip6tables"
	IPTSv6="echo /sbin/ip6tables-save"
	IPTRv6="echo /sbin/ip6tables-restore"
	echo "## Verbose variables loaded,modifications should happen to currently running firewall rules"
	echo "#	as they apear"
}
Load_Checker_Variables(){
	Out_File_Parcer "$1"
	IPTv4="echo # /sbin/iptables"
	IPTSv4="echo # /sbin/iptables-save"
	IPTRv4="echo # /sbin/iptables-restore"
	IPTv6="echo # /sbin/ip6tables"
	IPTSv6="echo # /sbin/ip6tables-save"
	IPTRv6="echo # /sbin/ip6tables-restore"
	echo "## Check variables loaded, no modifications should happen to currently running firewall rules"
}
Out_File_Parcer(){
	_Out_File="${1:-$HOME/iptables_verbose_$(date +%F).log}"
	case ${_Out_File} in
		/*)
			_ECHO="echo #"
			if [ -f "${_Out_File}" ]; then
				Out_File="| tee -a ${_Out_File}"
				_comment="| tee -a ${_Out_File}"
				echo "## Verbose output set to : [${Out_File}]"
				echo "#	Comments output set to : [${_comment}]"
			else
				echo "## Error file does not exsist : [${_Out_File}]"
				echo "#	Press [Enter] to make the output file read"
				echo "#	[${Out_File}] and continue"
				echo "#	or press [Ctrl^c] to quit now..."
				read
				Out_File="| tee -a ${_Out_File}"
				_comment="| tee -a ${_Out_File}"
				touch ${_Out_File}
			fi
		;;
		*)
			_ECHO="echo #"
			Out_File="| tee -a /dev/null"
			_comment="| tee -a /dev/null"
			echo "## Verbose setting on, however, output file set to [${Out_File}]"
			echo "#	Comments will also be printed but not saved [${_comment}]"
		;;
	esac
	echo "## Setting output of commented sections from [2>&1 /dev/null] to [3>&1 1>/dev/null 2>&3- | tee -a /var/log/${_self}_error.log]"
	echo "#	Setting iptables variables to output to stout such that these commands are show."
	echo "#	Note if [${Out_File}] is not set to [/dev/null] you may use this file to restore settings"
}
### Iptables_usage_parser_help parse_iptables_options_help parse_iptables_options.sh
#	File:	${_script_dir}/functions/iptables/parse_iptables_options.sh

#${_self} understands the following arguments...
#-h  --help		Prints this message and exits
#-v  --version		Prints ${_self} version and exits
#-V  --verbose 		Prints commented sections of ${_self} as processed
#	and outputs to either /dev/null or to a file via [-V=/some/file]
#	Note : this in combination with [-c] will produce files that can be quickly modfide
#	into verbosely noted custom scripts without touching currently running firewall rules
#-C  --check 		Prints veriables durring fake run of ${_self}, maybe combined with
#	verbose options, ie, [-C -V=/some/file] to inspect how this script will apply settings 
#	without touching current firewall or without verbose options, [-C=/some/file] to output
#	custom firewall rules to a file without effecting the curent firewall settings. Note,
#	without [-V=/some/file] or [-C=/some/file], ie, [-C -V] then no modifications will take
#	effect on current firewall rules and no output file will be saved.
#-LI --loc-iface		Accepts interfaces to add to local interfaces list
#-SI --srv-iface		Accepts interfaces to add to local interfaces list
#	Multiple interfaces maybe added via [-LI=loc_int1,loc_int2] and/or [-SI=srv_int1,srv_int2]
#	by seperatting interfaces by "," these interfaces will have the related IP addresses
#	assosiated automaticly if up and thier ports opened for either local or server named ports
####
