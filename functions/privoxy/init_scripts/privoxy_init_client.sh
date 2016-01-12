Privoxy_init_client(){
	Arg_checker "${@:---help='Privoxy_init_client' --exit='# [Privoxy_init_client] # Failed to be read arguments'}" -ep='Privoxy_init_client'
	_init_count="${_connection_count:-8}"
	_init_dir="${_privoxy_dir:-/etc}/init.d"
	Overwrite_init_checker "${_privoxy_dir}" "privoxy"
	echo '#!/bin/bash' | sudo tee -a ${_init_dir}/privoxy
	echo '### BEGIN INIT INFO' | sudo tee -a ${_init_dir}/privoxy
	echo '# Provides:		privoxy' | sudo tee -a ${_init_dir}/privoxy
	echo '# Required-Start:		$local_fs $remote_fs $network $time' | sudo tee -a ${_init_dir}/privoxy
	echo '# Required-Stop:		$local_fs $remote_fs $network $time' | sudo tee -a ${_init_dir}/privoxy
	echo '# Default-Start:		2 3 4 5' | sudo tee -a ${_init_dir}/privoxy
	echo '# Default-Stop:		0 1 6' | sudo tee -a ${_init_dir}/privoxy
	echo '# Short-Description:	Privacy enhancing HTTP proxy' | sudo tee -a ${_init_dir}/privoxy
	echo '# Description:		Privoxy is a web proxy with advanced filtering' | sudo tee -a ${_init_dir}/privoxy
	echo '#				capabilities for protecting privacy, filtering' | sudo tee -a ${_init_dir}/privoxy
	echo '#				web page content, managing cookies, controlling' | sudo tee -a ${_init_dir}/privoxy
	echo '#				access, and removing ad banners, pop-ups and' | sudo tee -a ${_init_dir}/privoxy
	echo '#				other obnoxious internet junk' | sudo tee -a ${_init_dir}/privoxy
	echo '# Author: 		Roland Rosenfeld <roland@debian.org>' | sudo tee -a ${_init_dir}/privoxy
	echo '# Guide-Source: 		https://terminal28.com/anonymity-online-how-to-install-and-configure-squid3-tor-privoxy-debian-ubuntu-linux/' | sudo tee -a ${_init_dir}/privoxy
	echo '### END INIT INFO' | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo '# Do NOT "set -e"' | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo '# PATH should only include /usr/* if it runs after the mountnfs.sh script' | sudo tee -a ${_init_dir}/privoxy
	echo 'PATH=/sbin:/usr/sbin:/bin:/usr/bin' | sudo tee -a ${_init_dir}/privoxy
	echo 'DESC="filtering proxy server"' | sudo tee -a ${_init_dir}/privoxy
	echo 'NAME=privoxy' | sudo tee -a ${_init_dir}/privoxy
	echo 'DAEMON=/usr/sbin/$NAME' | sudo tee -a ${_init_dir}/privoxy
	echo 'PIDFILE=/var/run/$NAMR' | sudo tee -a ${_init_dir}/privoxy
	echo 'OWNER=privoxy' | sudo tee -a ${_init_dir}/privoxy
	echo 'CONFIGFILE=/etc/init.d/$NAME' | sudo tee -a ${_init_dir}/privoxy
	echo 'LOGDIR=/var/log/privoxy' | sudo tee -a ${_init_dir}/privoxy
	echo 'DEFAULTSFILE=/etc/default/$NAME' | sudo tee -a ${_init_dir}/privoxy
	echo "_INIT_COUNT=${_init_count}" | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo '# Exit if the package is not installed' | sudo tee -a ${_init_dir}/privoxy
	echo '[ -x "$DAEMON" ] || exit 0' | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo '# Read configuration variable file if it is present' | sudo tee -a ${_init_dir}/privoxy
	echo '[ -r $DEFAULTSFILE ] && . $DEFAULTSFILE' | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo '# Create log directory if it does not exist' | sudo tee -a ${_init_dir}/privoxy
	echo 'if [ ! -d "$LOGDIR" ]; then' | sudo tee -a ${_init_dir}/privoxy
	echo '	mkdir -m 750 $LOGDIR' | sudo tee -a ${_init_dir}/privoxy
	echo '	chown $OWNER:adm $LOGDIR' | sudo tee -a ${_init_dir}/privoxy
	echo 'fi' | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo '# Load the VERBOSE setting and other rcS variables' | sudo tee -a ${_init_dir}/privoxy
	echo '. /lib/init/vars.sh' | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo '# Define LSB log_* functions.' | sudo tee -a ${_init_dir}/privoxy
	echo '# Depends on lsb-base (>= 3.0-6) to ensure that this file is present' | sudo tee -a ${_init_dir}/privoxy
	echo '. /lib/lsb/init-functions' | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo '#' | sudo tee -a ${_init_dir}/privoxy
	echo '# Functions that starts the daemon/service' | sudo tee -a ${_init_dir}/privoxy
	echo '#' | sudo tee -a ${_init_dir}/privoxy
	echo 'do_start () {' | sudo tee -a ${_init_dir}/privoxy
	echo '	# Return' | sudo tee -a ${_init_dir}/privoxy
	echo '	#	0 if daeon has been started' | sudo tee -a ${_init_dir}/privoxy
	echo '	#	1 if daemon was already running' | sudo tee -a ${_init_dir}/privoxy
	echo '	#	2 if daemon could not be started' | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo '	status=0' | sudo tee -a ${_init_dir}/privoxy
	echo '	for c in {1..$_INIT_COUNT}' | sudo tee -a ${_init_dir}/privoxy
	echo '	do' | sudo tee -a ${_init_dir}/privoxy
	echo '		DAEMON_ARGS="--pidfile $PIDFILE-$c.pid $CONFIGFILE-$c"' | sudo tee -a ${_init_dir}/privoxy
	echo '		start-stop-daemon --start --quiet --pidfile $PIDFILE-$c.pid --exec $DAEMON -- $DAEMON_ARGS || stats=2' | sudo tee -a ${_init_dir}/privoxy
	echo '	done' | sudo tee -a ${_init_dir}/privoxy
	echo '	return "$stats"' | sudo tee -a ${_init_dir}/privoxy
	echo '	# Add code here, if necessary, that waits for the process to be ready' | sudo tee -a ${_init_dir}/privoxy
	echo '	# to handle requests from services started subsequently which depend' | sudo tee -a ${_init_dir}/privoxy
	echo '	# on this one. As a last resort, sleep for some time' | sudo tee -a ${_init_dir}/privoxy
	echo '}' | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo '#' | sudo tee -a ${_init_dir}/privoxy
	echo '# Function that stops the deamon/service' | sudo tee -a ${_init_dir}/privoxy
	echo '#' | sudo tee -a ${_init_dir}/privoxy
	echo 'do_stop () {' | sudo tee -a ${_init_dir}/privoxy
	echo '	for c in {1..$_INIT_COUNT}' | sudo tee -a ${_init_dir}/privoxy
	echo '	do' | sudo tee -a ${_init_dir}/privoxy
	echo '		# Return' | sudo tee -a ${_init_dir}/privoxy
	echo '		#	0 if daemon has been started' | sudo tee -a ${_init_dir}/privoxy
	echo '		#	1 if daemon was already stopped' | sudo tee -a ${_init_dir}/privoxy
	echo '		#	2 if daemon could not be stopped' | sudo tee -a ${_init_dir}/privoxy
	echo '		#	other if failure occurred' | sudo tee -a ${_init_dir}/privoxy
	echo '		start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --pidfile $PIDFILE-$c.pid --name $NAME' | sudo tee -a ${_init_dir}/privoxy
	echo '		RETVAL="$?"' | sudo tee -a ${_init_dir}/privoxy
	echo '		[ "$RETVAL" = "2" ] && return 2' | sudo tee -a ${_init_dir}/privoxy
	echo '		# Wait for children to finish too if this is a daemon that forks' | sudo tee -a ${_init_dir}/privoxy
	echo '		# and if the daemon is only ever run from this initscript' | sudo tee -a ${_init_dir}/privoxy
	echo '		# that waits for the process to drop all resources that could be' | sudo tee -a ${_init_dir}/privoxy
	echo '		# needed by services started subsequently. A last resort is to' | sudo tee -a ${_init_dir}/privoxy
	echo '		# sleep for some time.' | sudo tee -a ${_init_dir}/privoxy
	echo '		start-stop-daemon --stop --quiet --oknodo --retry=0/30/KILL/5 --exec $DAEMON' | sudo tee -a ${_init_dir}/privoxy
	echo '		[ "$?" = "2" ] $$ return 2' | sudo tee -a ${_init_dir}/privoxy
	echo '		# Many daemons do not delete thier pidfiles when they exit' | sudo tee -a ${_init_dir}/privoxy
	echo '		rm -f $PIDFILE-$c.pid' | sudo tee -a ${_init_dir}/privoxy
	echo '	done' | sudo tee -a ${_init_dir}/privoxy
	echo '	return "$RETVAL"' | sudo tee -a ${_init_dir}/privoxy
	echo '}' | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo '#' | sudo tee -a ${_init_dir}/privoxy
	echo '# Function that sends a SIGHUP to deamon/service' | sudo tee -a ${_init_dir}/privoxy
	echo '#' | sudo tee -a ${_init_dir}/privoxy
	echo 'do_reload () {' | sudo tee -a ${_init_dir}/privoxy
	echo '	#' | sudo tee -a ${_init_dir}/privoxy
	echo '	# If the daemon can reload its configuration without' | sudo tee -a ${_init_dir}/privoxy
	echo '	# restarting (for example, when it is sent a SIGHUP),' | sudo tee -a ${_init_dir}/privoxy
	echo '	# then implement that here.' | sudo tee -a ${_init_dir}/privoxy
	echo '	#' | sudo tee -a ${_init_dir}/privoxy
	echo '	start-stop-daemon --stop --signal 1 --quiet --pidfile $PIDFILE --name $NAME' | sudo tee -a ${_init_dir}/privoxy
	echo '	return 0' | sudo tee -a ${_init_dir}/privoxy
	echo '}' | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo 'case "$1" in' | sudo tee -a ${_init_dir}/privoxy
	echo '	start)' | sudo tee -a ${_init_dir}/privoxy
	echo '		if [ "$RUN_DAEMON" = "no" ]; then' | sudo tee -a ${_init_dir}/privoxy
	echo '			[ "$VERBOSE" != no ] && log_warning_msg "Not starting $DESC (disabled in $DEFAULTSFILE)"' | sudo tee -a ${_init_dir}/privoxy
	echo '			exit 0' | sudo tee -a ${_init_dir}/privoxy
	echo '		fi' | sudo tee -a ${_init_dir}/privoxy
	echo '' | sudo tee -a ${_init_dir}/privoxy
	echo '	[ "$VERBOSE" != "no" ] && log_daemon_msg "Starting $DESC" "$NAME"' | sudo tee -a ${_init_dir}/privoxy
	echo '	do_start' | sudo tee -a ${_init_dir}/privoxy
	echo '	case "$?" in' | sudo tee -a ${_init_dir}/privoxy
	echo '		0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;' | sudo tee -a ${_init_dir}/privoxy
	echo '		2) [ "$VERBOSE" != no ] && log_end_msg 1;;' | sudo tee -a ${_init_dir}/privoxy
	echo '	esac' | sudo tee -a ${_init_dir}/privoxy
	echo '	;;' | sudo tee -a ${_init_dir}/privoxy
	echo '	stop)' | sudo tee -a ${_init_dir}/privoxy
	echo '		[ "$VERBOSE" != no ] && log_daemon_msg "Stoppin $DESC" "$NAME"' | sudo tee -a ${_init_dir}/privoxy
	echo '		do_stop' | sudo tee -a ${_init_dir}/privoxy
	echo '		case "$?" in' | sudo tee -a ${_init_dir}/privoxy
	echo '			0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;' | sudo tee -a ${_init_dir}/privoxy
	echo '			2) [ "$VERBOSE" != no ] && log_end_msg 1;;' | sudo tee -a ${_init_dir}/privoxy
	echo '		esac' | sudo tee -a ${_init_dir}/privoxy
	echo '		;;' | sudo tee -a ${_init_dir}/privoxy
	echo '	;;' | sudo tee -a ${_init_dir}/privoxy
	echo '	restart|force-reload)' | sudo tee -a ${_init_dir}/privoxy
	echo '		if [ "$RUN_DAEMON" = "no" ]; then' | sudo tee -a ${_init_dir}/privoxy
	echo '			[ "$VERBOSE" != no ] && log_warning_msg "Not restarting $DESC (dissabled in $DEFAULTSFILE)."' | sudo tee -a ${_init_dir}/privoxy
	echo '			exit 0' | sudo tee -a ${_init_dir}/privoxy
	echo '		fi' | sudo tee -a ${_init_dir}/privoxy
	echo '		log_daemon_msg "Restarting $DESC" "$NAME"' | sudo tee -a ${_init_dir}/privoxy
	echo '		do_stop' | sudo tee -a ${_init_dir}/privoxy
	echo '		case "$?" in' | sudo tee -a ${_init_dir}/privoxy
	echo '			0|1)' | sudo tee -a ${_init_dir}/privoxy
	echo '				do_start' | sudo tee -a ${_init_dir}/privoxy
	echo '				case "$?" in' | sudo tee -a ${_init_dir}/privoxy
	echo '					0) log_end_msg 0 ;;' | sudo tee -a ${_init_dir}/privoxy
	echo '					1) log_end_msg 1 ;; # Old process is still running' | sudo tee -a ${_init_dir}/privoxy
	echo '					2) log_end_msg 1 ;; # Failed to start' | sudo tee -a ${_init_dir}/privoxy
	echo '				esac' | sudo tee -a ${_init_dir}/privoxy
	echo '			;;' | sudo tee -a ${_init_dir}/privoxy
	echo '			*)' | sudo tee -a ${_init_dir}/privoxy
	echo '				# Failed to stop' | sudo tee -a ${_init_dir}/privoxy
	echo '				log_end_msg 1' | sudo tee -a ${_init_dir}/privoxy
	echo '			;;' | sudo tee -a ${_init_dir}/privoxy
	echo '		esac' | sudo tee -a ${_init_dir}/privoxy
	echo '	;;' | sudo tee -a ${_init_dir}/privoxy
	echo '	status)' | sudo tee -a ${_init_dir}/privoxy
	echo '		status_of_proc "$DAEMON" "$NAMR"' | sudo tee -a ${_init_dir}/privoxy
	echo '		exit $?' | sudo tee -a ${_init_dir}/privoxy
	echo '	;;' | sudo tee -a ${_init_dir}/privoxy
	echo '	*)' | sudo tee -a ${_init_dir}/privoxy
	echo '		echo "Usage: $SCRIPTNAME {start|stop|restart|force-reload|status}" >&2' | sudo tee -a ${_init_dir}/privoxy
	echo '		exit 3' | sudo tee -a ${_init_dir}/privoxy
	echo '	;;' | sudo tee -a ${_init_dir}/privoxy
	echo '	esac' | sudo tee -a ${_init_dir}/privoxy
	echo '	:' | sudo tee -a ${_init_dir}/privoxy
	echo "## Notice [Privoxy_init_client] function finished writing [${_init_dir}/privoxy] file"
	echo '#	Now providing exicutable permissions'
	sudo chmod +x ${_init_dir}/privoxy
}
### Privoxy_init_client_help privoxy_init_client_help privoxy_init_client.sh
#	File: ${_script_dir}/functions/privoxy/init_scripts/privoxy_init_client.sh
#	This function is passed two arguments from [] function
#	First [${_etc_dir:-/etc}] is the directory to look for [init.d] directory for start/stop scripts
#	Second [${_connection_count:-8}] is the number of privoxy services to spin up
#	Only reason that this function should be run is if [${_script_name}] detects [-T='client']
#	as an option. Connection count is related to the number passed to [${_script_nam}]
#	via [-C='8'] command.
#	Argument	Variable		Default
#	[-PD=...]	_privoxy_dir		/etc
#	[-C=...]	_connection_count	8
####
