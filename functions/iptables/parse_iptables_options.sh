Parse_iptables_options(){
	_prefix=""
	_key=""
	_value=""
	for _KEY in $@; do
		case "${_prefix}${_KEY}" in
			-LI=*|--local-iface=*) 		_key="-LI" ;	_value="${_KEY#*=}" ;;
			-SI=*|--server-iface=*)		_key="-SI" ;	_value="${_KEY#*=}" ;;
			*) 							_key="_0" ; 	_value="$_{KEY#*=}" ;;
		esac
		case $_key in
			-LI)
				_prefix="" ; _key=""
				echo "##	Usage_Parcer read additional local interfaces : [${_value}]"
				Local_Interface="${_value},${Local_Interface}"
			;;
			-SI)
				_prefix="" ; _key=""
				echo "##	Usage_Parcer read additional server interfaces : [${_value}]"
				Server_Interface="${_value},${Server_Interface}"
			;;
			_0)
				_prefix="${_KEY}=" ; _key=""
				Parse_help "Parse_iptables_options"
				exit 2
			;;
		esac
	done
}

#-LI --loc-iface		Accepts interfaces to add to local interfaces list
#-SI --srv-iface		Accepts interfaces to add to local interfaces list
#	Multiple interfaces maybe added via [-LI=loc_int1,loc_int2] and/or [-SI=srv_int1,srv_int2]
#	by seperatting interfaces by "," these interfaces will have the related IP addresses
#	assosiated automaticly if up and thier ports opened for either local or server named ports
####
