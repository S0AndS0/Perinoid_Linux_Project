Write_tor_client_rcd(){
	_count="${1:-$_connection_count}"
	_count="${_count:-8}"
	_path="${2:-$_rcd_path}"
	_path="${_path:-/etc/rc.d}"
	if [ -f ${_path}/tor ]; then
		echo "## Found old ${_path}/tor script, backing it up and writing new one"
		sudo mv ${_path}/tor ${_path}/tor.orig
		echo '#!/bin/bash' | sudo tee -a ${_path}/tor
		echo '. /etc/rc.conf' | sudo tee -a ${_path}/tor
		echo '. /etc/rc.d/functions' | sudo tee -a ${_path}/tor
		echo '#PID=`pidof -o %PPID /usr/bin/tor`' | sudo tee -a ${_path}/tor
		echo 'tor=`/usr/bin/tor`' | sudo tee -a ${_path}/tor
		echo 'case "$1" in' | sudo tee -a ${_path}/tor
		echo '	start)' | sudo tee -a ${_path}/tor
		echo '		stat_busy "Starting Tor Daemon"' | sudo tee -a ${_path}/tor
		echo '		for c in {1..$_count}; do' | sudo tee -a ${_path}/tor
		echo '			if [ $c = 1 ]; then' | sudo tee -a ${_path}/tor
		echo '				${tor} -f /etc/tor/torrc' | sudo tee -a ${_path}/tor
		echo '			elif [ $c -gt 1 ]; then' | sudo tee -a ${_path}/tor
		echo '				${tor} -f /etc/tor/torrc$c' | sudo tee -a ${_path}/tor
		echo '			fi' | sudo tee -a ${_path}/tor
		echo '		done' | sudo tee -a ${_path}/tor
		echo '		if [ $? -gt 0 ]; then' | sudo tee -a ${_path}/tor
		echo '			stat_fail' | sudo tee -a ${_path}/tor
		echo '		fi' | sudo tee -a ${_path}/tor
		echo '	;;' | sudo tee -a ${_path}/tor
		echo '	stop)' | sudo tee -a ${_path}/tor
		echo '		stat_busy "Stopping Tor Daemon"' | sudo tee -a ${_path}/tor
		echo '		#[ ! -z "$PID" ] && kill $PID &> /dev/null' | sudo tee -a ${_path}/tor
		echo '		killall tor' | sudo tee -a ${_path}/tor
		echo '		if [ $? -gt 0 ]; then' | sudo tee -a ${_path}/tor
		echo '			stat_fail' | sudo tee -a ${_path}/tor
		echo '		else' | sudo tee -a ${_path}/tor
		echo '			rm_daemon tor' | sudo tee -a ${_path}/tor
		echo '			stat_done' | sudo tee -a ${_path}/tor
		echo '		fi' | sudo tee -a ${_path}/tor
		echo '	;;' | sudo tee -a ${_path}/tor
		echo '	restart)' | sudo tee -a ${_path}/tor
		echo '		$0 stop' | sudo tee -a ${_path}/tor
		echo '		sleep 3' | sudo tee -a ${_path}/tor
		echo '		$0 start' | sudo tee -a ${_path}/tor
		echo '	;;' | sudo tee -a ${_path}/tor
		echo '	*)' | sudo tee -a ${_path}/tor
		echo '		echo "usage: $0 {start|stop|restart}"' | sudo tee -a ${_path}/tor
		echo '	;;' | sudo tee -a ${_path}/tor
		echo 'esac' | sudo tee -a ${_path}/tor
		echo 'exit 0' | sudo tee -a ${_path}/tor
		echo '# vim: ft=sh ts=2 sw=2' | sudo tee -a ${_path}/tor
	fi
}
### Write_tor_client_rcd_help write_tor_client_rcd_help write_tor_client_rcd.sh
#	File: ${_script_dir}/functions/tor/rcd_writers/write_tor_client_rcd.sh
#	Not used as of yet, future versions of [${_script_name}] script will
#	hopefully support Arch based Linux distros. Currently this is bypassed
#	by running most services withing Debian based chroots.
####
