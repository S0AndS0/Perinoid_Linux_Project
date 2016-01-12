Write_tor_init_client(){
	Arg_checker "${@:---help='Write_tor_init_client' --exit='# [Write_tor_init_client] # Failed to be read arguments'}" -ep='Write_tor_init_client'
	_init_dir="${_tor_directory:-/etc/}init.d"
	Overwrite_init_checker "${_tor_directory}" "tor_client"
	echo '## Attention [Write_tor_init_client] function now writing init script with assigned variables'
	echo "#	to [${_init_dir}/tor_client] file"
	echo '#!/bin/bash' | sudo tee -a ${_init_dir}/tor_client
	echo '### BEGIN INIT INFO' | sudo tee -a ${_init_dir}/tor_client
	echo "# Provides:		tor clients 1-${_connection_count}" | sudo tee -a ${_init_dir}/tor_client
	echo '# Required-Start:		$local_fs $remote_fs $network $named $time' | sudo tee -a ${_init_dir}/tor_client
	echo '# Required-Stop:		$local_fs $remote_fs $network $named $time' | sudo tee -a ${_init_dir}/tor_client
	echo '# Should-Start:		$syslog' | sudo tee -a ${_init_dir}/tor_client
	echo '# Should-Stop:		$syslog' | sudo tee -a ${_init_dir}/tor_client
	echo '# Default-Start:		2 3 4 5' | sudo tee -a ${_init_dir}/tor_client
	echo '# Default-Stop:		0 1 6' | sudo tee -a ${_init_dir}/tor_client
	echo '# Short-Description:	Starts The Onion Router daemon processes' | sudo tee -a ${_init_dir}/tor_client
	echo '# Description:		Starts The Onion Router, a TCP overlay' | sudo tee -a ${_init_dir}/tor_client
	echo '#				network client that provides anonymous' | sudo tee -a ${_init_dir}/tor_client
	echo '#				trasport. See following link for source' | sudo tee -a ${_init_dir}/tor_client
	echo '#				of this script' | sudo tee -a ${_init_dir}/tor_client
	echo '#				https://terminal28.com/anonymity-online-how-to-install-and-configure-squid3-tor-privoxy-debian-ubuntu-linux/' | sudo tee -a ${_init_dir}/tor_client
	echo '### END INIT INFO' | sudo tee -a ${_init_dir}/tor_client
	echo 'set -e' | sudo tee -a ${_init_dir}/tor_client
	echo 'PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin' | sudo tee -a ${_init_dir}/tor_client
## Note if installing from source some of these file path
#	variables may need changed
	echo 'DAEMON=/usr/sbin/tor' | sudo tee -a ${_init_dir}/tor_client
	echo 'NAME=tor' | sudo tee -a ${_init_dir}/tor_client
	echo 'DESC="tor daemon"' | sudo tee -a ${_init_dir}/tor_client
	echo "CONFDIR=${_tor_directory:-/etc}/tor" | sudo tee -a ${_init_dir}/tor_client
	echo 'TORPIDDIR=/var/run/tor_clients' | sudo tee -a ${_init_dir}/tor_client
	echo 'TORPID=$TORPIDDIR/tor_client' | sudo tee -a ${_init_dir}/tor_client
	echo "DEFAULTSFILE=${_tor_directory:-/etc}/defaults/\$NAME" | sudo tee -a ${_init_dir}/tor_client
	echo 'WAITFORDEAMON=60' | sudo tee -a ${_init_dir}/tor_client
	echo 'ARGS="--quiet -f"$CONFDIR/torrc' | sudo tee -a ${_init_dir}/tor_client
	echo '## Modify $_init_count if you add or remove tor client processes at a latter time' | sudo tee -a ${_init_dir}/tor_client
	echo "_init_count=${_connection_count}" | sudo tee -a ${_init_dir}/tor_client
	echo '# Set sane defaults' | sudo tee -a ${_init_dir}/tor_client
	echo 'if [ -r /proc/sys/fs/file-max ]; then' | sudo tee -a ${_init_dir}/tor_client
	echo '	system_max=`cat /proc/sys/fs/file-max`' | sudo tee -a ${_init_dir}/tor_client
	echo '	if [ "$system_max" -gt "80000" ]; then' | sudo tee -a ${_init_dir}/tor_client
	echo '		MAX_FILEDESCRIPTORS=32768' | sudo tee -a ${_init_dir}/tor_client
	echo '	elif [ "$system_max" -gt "40000" ]; then' | sudo tee -a ${_init_dir}/tor_client
	echo '		MAX_FILEDESCRIPTORS=16384' | sudo tee -a ${_init_dir}/tor_client
	echo '	elif [ "$system_max" -gt "10000" ]; then' | sudo tee -a ${_init_dir}/tor_client
	echo '		MAX_FILEDESCRIPTORS=8192' | sudo tee -a ${_init_dir}/tor_client
	echo '	else' | sudo tee -a ${_init_dir}/tor_client
	echo '		MAX_FILEDESCRIPTORS=1024' | sudo tee -a ${_init_dir}/tor_client
	echo '		cat << EOF' | sudo tee -a ${_init_dir}/tor_client
	echo 'Warning: Your system has very few filedescriptors available in total' | sudo tee -a ${_init_dir}/tor_client
	echo "Maybe you should try rassing that by adding 'fs.file-max=10000' to your" | sudo tee -a ${_init_dir}/tor_client
	echo '/etc/sysctl.conf file. Feel free to pick any number that you deem appropriate.' | sudo tee -a ${_init_dir}/tor_client
	echo "Then run 'sysctl -p'. See /proc/sys/fs/file-max for the current value, and" | sudo tee -a ${_init_dir}/tor_client
	echo 'file-nr in the same directory for how many of those are sed at the moment' | sudo tee -a ${_init_dir}/tor_client
	echo 'EOF' | sudo tee -a ${_init_dir}/tor_client
	echo '	fi' | sudo tee -a ${_init_dir}/tor_client
	echo 'else' | sudo tee -a ${_init_dir}/tor_client
	echo '	MAX_FILEDESCRIPTORS=8192' | sudo tee -a ${_init_dir}/tor_client
	echo 'fi' | sudo tee -a ${_init_dir}/tor_client
	echo '' | sudo tee -a ${_init_dir}/tor_client
	echo 'NICE=""' | sudo tee -a ${_init_dir}/tor_client
	echo 'test -x $DEAMON || exit 0' | sudo tee -a ${_init_dir}/tor_client
	echo '# Include tor defaults if available' | sudo tee -a ${_init_dir}/tor_client
	echo 'if [ -f $DEFAULTSFILE ]; then' | sudo tee -a ${_init_dir}/tor_client
	echo '	. $DEFAULTSFILE' | sudo tee -a ${_init_dir}/tor_client
	echo 'fi' | sudo tee -a ${_init_dir}/tor_client
	echo 'wait_for_deaddaemon () {' | sudo tee -a ${_init_dir}/tor_client
	echo '	pid=$1' | sudo tee -a ${_init_dir}/tor_client
	echo '	sleep 1' | sudo tee -a ${_init_dir}/tor_client
	echo '	if test -n "$pid"' | sudo tee -a ${_init_dir}/tor_client
	echo '	then' | sudo tee -a ${_init_dir}/tor_client
	echo '		if kill -0 $pid 2>/dev/null' | sudo tee -a ${_init_dir}/tor_client
	echo '		then' | sudo tee -a ${_init_dir}/tor_client
	echo '			echo -n "."' | sudo tee -a ${_init_dir}/tor_client
	echo '			cnt=0' | sudo tee -a ${_init_dir}/tor_client
	echo '			while kill -0 $pid 2>/dev/null' | sudo tee -a ${_init_dir}/tor_client
	echo '			do' | sudo tee -a ${_init_dir}/tor_client
	echo '				cnt=`expr $cnt + 1`' | sudo tee -a ${_init_dir}/tor_client
	echo '				if [ $cnt -gt $WAITFORDAEMON  ]; then' | sudo tee -a ${_init_dir}/tor_client
	echo '					echo " FAILED "' | sudo tee -a ${_init_dir}/tor_client
	echo '					RETURN 1' | sudo tee -a ${_init_dir}/tor_client
	echo '				fi' | sudo tee -a ${_init_dir}/tor_client
	echo '				sleep 1' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo -n "."' | sudo tee -a ${_init_dir}/tor_client
	echo '			done' | sudo tee -a ${_init_dir}/tor_client
	echo '		fi' | sudo tee -a ${_init_dir}/tor_client
	echo '	fi' | sudo tee -a ${_init_dir}/tor_client
	echo '	return 0' | sudo tee -a ${_init_dir}/tor_client
	echo '}' | sudo tee -a ${_init_dir}/tor_client
	echo 'check_torpiddir () {' | sudo tee -a ${_init_dir}/tor_client
	echo '	if test ! -d $TORPIDDIR' | sudo tee -a ${_init_dir}/tor_client
	echo '	then' | sudo tee -a ${_init_dir}/tor_client
	echo '		echo "There is no $TORPIDDIR directory. Creating one for you."' | sudo tee -a ${_init_dir}/tor_client
	echo '		mkdir -m 02750 "$TORPIDDIR"' | sudo tee -a ${_init_dir}/tor_client
	echo "		chown $_tor_user:$_tor_user \"\$TORPIDDIR\"" | sudo tee -a ${_init_dir}/tor_client
	echo '	fi' | sudo tee -a ${_init_dir}/tor_client
	echo '	if test ! -x $TORPIDDIR' | sudo tee -a ${_init_dir}/tor_client
	echo '	then' | sudo tee -a ${_init_dir}/tor_client
	echo '		echo "Cannot access $TORPIDDIR directory, are you root?" >&2' | sudo tee -a ${_init_dir}/tor_client
	echo '		exit 1' | sudo tee -a ${_init_dir}/tor_client
	echo '	fi' | sudo tee -a ${_init_dir}/tor_client
	echo '}' | sudo tee -a ${_init_dir}/tor_client
	echo 'check_config () {' | sudo tee -a ${_init_dir}/tor_client
	echo '	if ! $DAEMON --verify-config > /dev/null' | sudo tee -a ${_init_dir}/tor_client
	echo '	then' | sudo tee -a ${_init_dir}/tor_client
	echo '		echo "ABORTED: Tor configuration invalid" >&2' | sudo tee -a ${_init_dir}/tor_client
	echo '		$DAEMON --verify-config >&2' | sudo tee -a ${_init_dir}/tor_client
	echo '		exit 1' | sudo tee -a ${_init_dir}/tor_client
	echo '	fi' | sudo tee -a ${_init_dir}/tor_client
	echo '}' | sudo tee -a ${_init_dir}/tor_client
	echo 'case "$1" in ' | sudo tee -a ${_init_dir}/tor_client
	echo '	start)' | sudo tee -a ${_init_dir}/tor_client
	echo '	if [ "$RUN_DAEMON" != "yes" ]; then' | sudo tee -a ${_init_dir}/tor_client
	echo '		echo "Not starting $DESC (Dissabled in $DEFAULTSFILE)."' | sudo tee -a ${_init_dir}/tor_client
	echo '		exit 0' | sudo tee -a ${_init_dir}/tor_client
	echo '	fi' | sudo tee -a ${_init_dir}/tor_client
	echo '	if [ -n "$MAX_FILEDESCRIPTORS" ]; then' | sudo tee -a ${_init_dir}/tor_client
	echo '		echo -n "Raising maximum number of filedescriptors (ulimit -n) to $MAX_FILEDESCRIPTORS"' | sudo tee -a ${_init_dir}/tor_client
	echo '		if ulimit -n "$MAX_FILEDESCRIPTORS"' | sudo tee -a ${_init_dir}/tor_client
	echo '		then' | sudo tee -a ${_init_dir}/tor_client
	echo '			echo "."' | sudo tee -a ${_init_dir}/tor_client
	echo '		else' | sudo tee -a ${_init_dir}/tor_client
	echo '			echo ": FAILED."' | sudo tee -a ${_init_dir}/tor_client
	echo '		fi' | sudo tee -a ${_init_dir}/tor_client
	echo '	fi' | sudo tee -a ${_init_dir}/tor_client
	echo '	check_torpiddir' | sudo tee -a ${_init_dir}/tor_client
	echo '	check_config' | sudo tee -a ${_init_dir}/tor_client
	echo '	echo "Starting $DESC: $NAME..."' | sudo tee -a ${_init_dir}/tor_client
	echo '	for c in {1..$_init_count}' | sudo tee -a ${_init_dir}/tor_client
	echo '	do' | sudo tee -a ${_init_dir}/tor_client
## Notice : this is where chroot, apparmor, and or firejail assignments should be added
	echo '		if start-stop-daemon --stop --signal 0 --quite --pidfile $TORPID-$c --exec $DAEMON; then' | sudo tee -a ${_init_dir}/tor_client
	echo '			echo "$NAME already running"' | sudo tee -a ${_init_dir}/tor_client
	echo '		else' | sudo tee -a ${_init_dir}/tor_client
	echo '			if [ "$USE_AA_EXEC" = "yes" ] && [ -x /usr/sbin/aa-status ] && [ -x /usr/sbin/aa-exec ] && [ -e /etc/apparmor.d/system_tor ] && /usr/sbin/aa-status --enabled ; then' | sudo tee -a ${_init_dir}/tor_client
	echo '				AA_EXEC="--startas /ust/sbin/aa-exec"' | sudo tee -a ${_init_dir}/tor_client
	echo '				AA_EXEC_ARGS="--profile=system_tor -- $DAEMON"' | sudo tee -a ${_init_dir}/tor_client
	echo '			else' | sudo tee -a ${_init_dir}/tor_client
	echo '				AA_EXEC=""' | sudo tee -a ${_init_dir}/tor_client
	echo '				AA_EXEC_ARGS=""' | sudo tee -a ${_init_dir}/tor_client
	echo '			fi' | sudo tee -a ${_init_dir}/tor_client
	echo '			if start-stop-daemon --start --quiet --oknodo --pidfile $TORPID-$c.pid $NICE $AA_EXEC --exec $DAEMON -- $AA_EXEC_ARGS $ARGS-$c; then' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "$NAME $c done"' | sudo tee -a ${_init_dir}/tor_client
	echo '			else' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "Error starting $NAME $c"' | sudo tee -a ${_init_dir}/tor_client
	echo '				return 1' | sudo tee -a ${_init_dir}/tor_client
	echo '			fi' | sudo tee -a ${_init_dir}/tor_client
	echo '		fi' | sudo tee -a ${_init_dir}/tor_client
	echo '	done' | sudo tee -a ${_init_dir}/tor_client
	echo '	;;' | sudo tee -a ${_init_dir}/tor_client
	echo '	stop)' | sudo tee -a ${_init_dir}/tor_client
	echo '		echo -n "Stopping $DESC: "' | sudo tee -a ${_init_dir}/tor_client
	echo '		for c in {1..$_init_count}' | sudo tee -a ${_init_dir}/tor_client
	echo '		do' | sudo tee -a ${_init_dir}/tor_client
	echo '			pid=`cat $TORPID-$c.pid 2>/dev/null` || true' | sudo tee -a ${_init_dir}/tor_client
	echo '			if test ! -f $TORPID-$c.pid -o -z "$pid"' | sudo tee -a ${_init_dir}/tor_client
	echo '			then' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "not running (there in no $TORPID-$c.pid)."' | sudo tee -a ${_init_dir}/tor_client
	echo '				exit 0' | sudo tee -a ${_init_dir}/tor_client
	echo '			fi' | sudo tee -a ${_init_dir}/tor_client
	echo '			if start-stop-daemon --stop --signal INT --quiet --pidfile $TORPID-$c.pid --exec $DAEMON' | sudo tee -a ${_init_dir}/tor_client
	echo '			then' | sudo tee -a ${_init_dir}/tor_client
	echo '				wait_for_deaddaemon $pid' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "$NAME $c stopped."' | sudo tee -a ${_init_dir}/tor_client
	echo '			elif kill -0 $pid 2>/dev/null' | sudo tee -a ${_init_dir}/tor_client
	echo '			then' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "FAILED (Is $pid not $NAME? Is $DAEMON a different binary now?)."' | sudo tee -a ${_init_dir}/tor_client
	echo '			else' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "FAILED ($DAEMON died: process $pid not running; or permission denied)."' | sudo tee -a ${_init_dir}/tor_client
	echo '			fi' | sudo tee -a ${_init_dir}/tor_client
	echo '		done' | sudo tee -a ${_init_dir}/tor_client
	echo '	;;' | sudo tee -a ${_init_dir}/tor_client
	echo '	reload|force-reload)' | sudo tee -a ${_init_dir}/tor_client
	echo '		for c on {1..$_init_count}' | sudo tee -a ${_init_dir}/tor_client
	echo '		do' | sudo tee -a ${_init_dir}/tor_client
	echo '			echo -n "Reloading $DESC configuration: "' | sudo tee -a ${_init_dir}/tor_client
	echo '			pid=`cat $TORPID-$c.pid 2>/dev/null` || true' | sudo tee -a ${_init_dir}/tor_client
	echo '			if' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "not running (there is no $TORPID-$c.pid)."' | sudo tee -a ${_init_dir}/tor_client
	echo '				exit 0' | sudo tee -a ${_init_dir}/tor_client
	echo '			fi' | sudo tee -a ${_init_dir}/tor_client
	echo '			check_config' | sudo tee -a ${_init_dir}/tor_client
	echo '' | sudo tee -a ${_init_dir}/tor_client
	echo '			if start-stop-daemon --stop --signal 1 --quiet --pidfile $TORPID-$c.pid --esec $DAEMON' | sudo tee -a ${_init_dir}/tor_client
	echo '			then' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "$NAME $c."' | sudo tee -a ${_init_dir}/tor_client
	echo '			elif kill -0 $pid 2>/dev/null' | sudo tee -a ${_init_dir}/tor_client
	echo '			then' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "FAILED (Is $pid not $NAME? Is $DAEMON a different binary now?)."' | sudo tee -a ${_init_dir}/tor_client
	echo '			else' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "FAILED ($DAEMON deid: process $pid not running; or permission denied)."' | sudo tee -a ${_init_dir}/tor_client
	echo '			fi' | sudo tee -a ${_init_dir}/tor_client
	echo '		done' | sudo tee -a ${_init_dir}/tor_client
	echo '	;;' | sudo tee -a ${_init_dir}/tor_client
	echo '	restart)' | sudo tee -a ${_init_dir}/tor_client
	echo '		check_config' | sudo tee -a ${_init_dir}/tor_client
	echo '		$0 stop' | sudo tee -a ${_init_dir}/tor_client
	echo '		sleep 1' | sudo tee -a ${_init_dir}/tor_client
	echo '		$0 start' | sudo tee -a ${_init_dir}/tor_client
	echo '	;;' | sudo tee -a ${_init_dir}/tor_client
	echo '	status)' | sudo tee -a ${_init_dir}/tor_client
	echo '		for c in {1..$_init_count}' | sudo tee -a ${_init_dir}/tor_client
	echo '		do' | sudo tee -a ${_init_dir}/tor_client
	echo '			if test ! -r $(dirname $TORPID-$c.pid); then' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "cannot read tor PID file"' | sudo tee -a ${_init_dir}/tor_client
	echo '				exit 4' | sudo tee -a ${_init_dir}/tor_client
	echo '			fi' | sudo tee -a ${_init_dir}/tor_client
	echo '			pid=`cat $TORPID-$c.pid 2>/dev/null` || true' | sudo tee -a ${_init_dir}/tor_client
	echo '			if test ! -f $TORPID-$c.pid -o -z "$pid"' | sudo tee -a ${_init_dir}/tor_client
	echo '			then' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "tor is not running"' | sudo tee -a ${_init_dir}/tor_client
	echo '				exit 3' | sudo tee -a ${_init_dir}/tor_client
	echo '			fi' | sudo tee -a ${_init_dir}/tor_client
	echo '			if ps "$pid" >/dev/null 2>&1' | sudo tee -a ${_init_dir}/tor_client
	echo '			then' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "tor $c is running"' | sudo tee -a ${_init_dir}/tor_client
	echo '			else' | sudo tee -a ${_init_dir}/tor_client
	echo '				echo "tor is not running"' | sudo tee -a ${_init_dir}/tor_client
	echo '				exit 1' | sudo tee -a ${_init_dir}/tor_client
	echo '			fi' | sudo tee -a ${_init_dir}/tor_client
	echo '		done' | sudo tee -a ${_init_dir}/tor_client
	echo '		exit 0' | sudo tee -a ${_init_dir}/tor_client
	echo '	;;' | sudo tee -a ${_init_dir}/tor_client
	echo '	*)' | sudo tee -a ${_init_dir}/tor_client
	echo '		echo "Usage: $0 (start|stop|restart|reload|force-reload|status)"' | sudo tee -a ${_init_dir}/tor_client
	echo '		exit 1' | sudo tee -a ${_init_dir}/tor_client
	echo '	;;' | sudo tee -a ${_init_dir}/tor_client
	echo 'esac' | sudo tee -a ${_init_dir}/tor_client
	echo 'exit 0' | sudo tee -a ${_init_dir}/tor_client
	sudo chmod +x ${_init_dir}/tor_client
#	echo '' | sudo tee -a ${_init_dir}/tor_client
#	echo "" | sudo tee -a ${_init_dir}/tor_client
}
### Write_tor_init_client_help write_tor_init_client_help write_tor_init_client.sh
#	File:	${_script_dir}/tor/functions/init_scripts/write_tor_init_client.sh
#	This function only is used if by Activate [client] is one of the arguments passed
#	from [${_script_name}] via [-T=client]
## Other arguments used are [-TD=${_tor_directory:-/etc/}] to set where to write init scripts
#	Argument	Variable		Default
#	[-C=...]	_connection_count	8
#	[-TD=...]	_tor_directory		/etc
####
