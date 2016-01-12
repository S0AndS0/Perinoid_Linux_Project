Write_tor_init_nonclient(){
	_tor_dir="${1:-/etc}"
	_tor_node_user="${2:-debian-tor}"
	_tor_node_nickname="${3:?}"
	_tor_node_type="${4:?}"
	_init_dir="${_tor_directory:-/etc}/init.d"
	Overwrite_init_checker "${_tor_directory}" "tor_${_tor_node_type}"
	echo "## Attention [Write_tor_init] function now writing init script with assigned variables"
	echo "#	to [${_init_dir}/tor_${_tor_node_type}] file for node [${_tor_node_nickname}] nickname..."
	echo '#!/bin/bash' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '### BEGIN INIT INFO' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo "# Provides:		tor ${_tor_node_nickname}" | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '# Required-Start:		$local_fs $remote_fs $network $named $time' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '# Required-Stop:		$local_fs $remote_fs $network $named $time' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '# Should-Start:		$syslog' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '# Should-Stop:		$syslog' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '# Default-Start:		2 3 4 5' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '# Default-Stop:		0 1 6' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '# Short-Description:	Starts The Onion Router daemon processes' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '# Description:		Starts The Onion Router, a TCP overlay' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '#				network client that provides anonymous' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '#				trasport. See following link for source' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '#				of this script' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '#				https://terminal28.com/anonymity-online-how-to-install-and-configure-squid3-tor-privoxy-debian-ubuntu-linux/' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '### END INIT INFO' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'set -e' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
## Note if installing from source some of these file path
#	variables may need changed
	echo 'DAEMON=/usr/sbin/tor' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo "NAME=tor" | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'DESC="tor daemon"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo "CONFDIR=${_tor_dir:-/etc}/tor" | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo "TORPIDDIR=/var/run/tor_${_tor_node_nickname}" | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo "TORPID=\$TORPIDDIR/tor_${_tor_node_nickname}" | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo "DEFAULTSFILE=${_tor_dir:-/etc}/defaults/\$NAME" | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'WAITFORDEAMON=60' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo "ARGS=\"--quiet -f\"\$CONFDIR/torrc-${_tor_node_nickname}\"" | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '# Set sane defaults' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'if [ -r /proc/sys/fs/file-max ]; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	system_max=`cat /proc/sys/fs/file-max`' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	if [ "$system_max" -gt "80000" ]; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		MAX_FILEDESCRIPTORS=32768' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	elif [ "$system_max" -gt "40000" ]; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		MAX_FILEDESCRIPTORS=16384' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	elif [ "$system_max" -gt "10000" ]; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		MAX_FILEDESCRIPTORS=8192' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	else' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		MAX_FILEDESCRIPTORS=1024' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		cat << EOF' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'Warning: Your system has very few filedescriptors available in total' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo "Maybe you should try rassing that by adding 'fs.file-max=10000' to your" | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '/etc/sysctl.conf file. Feel free to pick any number that you deem appropriate.' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo "Then run 'sysctl -p'. See /proc/sys/fs/file-max for the current value, and" | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'file-nr in the same directory for how many of those are sed at the moment' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'EOF' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'else' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	MAX_FILEDESCRIPTORS=8192' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'NICE=""' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'test -x $DEAMON || exit 0' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '# Include tor defaults if available' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'if [ -f $DEFAULTSFILE ]; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	. $DEFAULTSFILE' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'wait_for_deaddaemon () {' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	pid=$1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	sleep 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	if test -n "$pid"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		if kill -0 $pid 2>/dev/null' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo -n "."' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			cnt=0' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			while kill -0 $pid 2>/dev/null' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			do' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '				cnt=`expr $cnt + 1`' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '				if [ $cnt -gt $WAITFORDAEMON  ]; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '					echo "still running"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '					exit 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '				fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '				sleep 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '				echo -n "."' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			done' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	return 0' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '}' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'check_torpiddir () {' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	if test ! -d $TORPIDDIR' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		echo "There is no $TORPIDDIR directory. Creating one for you."' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		mkdir -m 02750 "$TORPIDDIR"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo "		chown ${_tor_node_user:-debian-tor}:${_tor_node_user:-debian-tor} \"\$TORPIDDIR\"" | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	if test ! -x $TORPIDDIR' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		echo "Cannot access $TORPIDDIR directory, are you root?" >&2' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		exit 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '}' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'check_config () {' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	if ! $DAEMON --verify-config > /dev/null' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		echo "ABORTED: Tor configuration invalid" >&2' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		$DAEMON --verify-config >&2' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		exit 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '}' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'check_torlogdir () {' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	if ! [ -d "$TORLOGDIR" ]; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		mkdir -m 02750 "$TORLOGDIR"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo "		chown ${_tor_node_user:-debian-tor}:adm \"\$TORLOGDIR\"" | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		! [ -x /sbin/restorecon ] || /sbin/restorecon \"$TORLOGDIR\"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '}' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'case "$1" in ' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	start)' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	if [ "$RUN_DAEMON" != "yes" ]; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		echo "Not starting $DESC (Dissabled in $DEFAULTSFILE)."' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		exit 0' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	if [ -n "$MAX_FILEDESCRIPTORS" ]; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		echo -n "Raising maximum number of filedescriptors (ulimit -n) to $MAX_FILEDESCRIPTORS"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		if ulimit -n "$MAX_FILEDESCRIPTORS"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "."' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		else' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo ": FAILED."' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	check_torpiddir' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	check_torlogdir' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	echo "Starting $DESC: $NAME..."' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	check_config' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	echo "Starting $DESC: $NAME..."' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
## Notice 1 : This is where firejail should be added if used,
#	otherwise try another "Sandbox" utility for keeping unknown
#	vunerabilities from easily infecting the rest of your system
## Notice 2 : This is also one of the places to modify if installing
#	app-amore from source, if you expect the next [if] statment
#	to find the app-armor exicutables
## Notice 3 : Additionally this is where calls to chroot should
#	be preformed if running in chroot jail.
	echo '	if start-stop-daemon --stop --signal 0 --quiet --pidfile $TORPID --exec $DAEMON; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		echo "$NAME already running"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	else' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		if [ "$USE_AA_EXEC" = "yes" ] && [ -x /usr/sbin/aa-status ] && [ -x /usr/sbin/aa-exec ] && [ -e /etc/apparmor.d/system_tor ] && /usr/sbin/aa-status --enabled ; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			AA_EXEC="--startas /usr/sbin/aa-exec"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			AA_EXEC_ARGS="--profile=system_tor -- $DAEMON"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		else' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			AA_EXEC=""' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			AA_EXEC_ARGS=""' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		if start-stop-daemon --start --quiet --pidfile $TORPID $NICE $AA_EXEC --exec $DAEMON -- $AA_EXEC_ARGS $DEFAULT_ARGS $ARGS; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "$NAME done"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		else' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "Error starting $NAME"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			return 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	;;' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	stop)' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		echo -n "Stopping $DESC: "' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		pid=$(cat $TORPID 2>/dev/null) || true' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		if ! test -f $TORPID -o -z "$pid"; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "not running"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			return 0' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		if start-stop-daemon --stop --signal INT --quite --pidfile $TORPID --exec $DAEMON; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			wait_for_deaddaemon $pid' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		elif kill -0 $pid 2>/dev/null; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "Is $pid not $NAME? Is $DAEMON a different binary now?"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			return 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		else' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "$DAEMON died: process $pid not running; or permission denied"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			return 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	;;' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
## End of nessisary edits section
	echo '	reload|force-reload)' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		check_config' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		echo "Reloading $DESC configuration"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		pid=$(cat $TORPID 2>/dev/null) || true' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		if test ! -f $TORPID -o -z "$pid"; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "not running - there is no $TORPID"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			return 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		if start-stop-daemon --stop --signal 1 --quiet --pidfile $TORPID --exec $DAEMON' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "done"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		elif kill -0 $pid 2>/dev/null; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "Is $pid not $NAME? Is $DAEMON a different binary now?"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			return 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		else' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "$DAEMON died: process $pid not running; or permission denied"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			return 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	;;' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	restart)' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		check_config' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		$0 stop' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		sleep 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		$0 start' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	;;' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	status)' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		if test ! -r $(dirname $TORPID); then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "cannot read PID file $TORPID"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			return 4' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		pid=$(cat $TORPID 2>/dev/null) || true' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		if test ! -f $TORPID -o -z "$pid"; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "$NAME is not running"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			return 3' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		if ps "$pid" >/dev/null 2>&1; then' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "$NAME is running"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			return 0' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		else' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			echo "$NAME is not running"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '			return 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		fi' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	;;' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	*)' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		echo "Usage: $0 (start|stop|restart|reload|force-reload|status)"' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '		return 1' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo '	;;' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'esac' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo 'exit 0' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
	echo "## Attention [Write_tor_init] function finished writing init file for [${_tor_node_type}]]"
	echo "#	now providing [${_init_dir}/tor_${_tor_node_type}] exicutable permissions"
	sudo chmod +x ${_init_dir}/tor_${_tor_node_type}
#	echo '' | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
#	echo "" | sudo tee -a ${_init_dir}/tor_${_tor_node_type}
}
###Write_tor_init_nonclient_help write_tor_init_nonclient_help write_tor_init_nonclient.sh
#	File:	${_script_dir}/tor/functions/init_scripts/write_tor_init_nonclient.sh
#	This function only is used if [bridge] or [exit] or [relay] or [service]
#	are one of the arguments passed from [${_script_name}] via [-T=bridge]
#	This function's arguments are set by [Parse_init_tor] function run-time
#	The firrst and second arguments are inherited from [-TD=...] and [-TU=...] arguments
#	passed to [${_script_name}. The third and fourth arguments are set while processing
#	what types of Tor services are to be enabled other than [client].
#	For example if [-T=bridge] then the third and fourth arguments become [${_tor_bridge_nickname}]
#	and [bridge] respectively; writes a file named [tor_bridge] under [/init.d] directory
#	in this example.
#	Agrument	Variable		Default
#	$1		_tor_dir		/etc
#	$2		_tor_node_user		debian-tor
#	$3		_tor_node_nickname	${3:?}
#	$4		_tor_node_type		${4:?}
####
