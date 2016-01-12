Polipo_init_client(){
	Arg_checker "${@:---help='' --exit;''}" -ep=''
	Overwrite_init_checker "${_polipo_dir}" "polipo"
	echo '#!/bin/sh' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '### BEGIN INIT INFO' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '# Provides:		polipo' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '# Required-Start:		$remote_fs' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '# Required-Stop:		$remote_fs' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '# Default-Start:		2 3 4 5' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '# Default-Stop:		0 1 6' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '# Short-Description:	Start or stop the polipo web cache' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '# Description:		This script controles caching web proxy' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '#				It is called from the boot, hault and reboot scripts' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '### END INIT INFO' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '# Author:	Tom Ellis Huckstep <tom-debian-polipo@jaguarpaw.co.uk>' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo 'set -e' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo 'PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo 'PPCTL=/usr/lib/polipo/polipo-control' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo 'test -x $PPCTL || exit 0' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo 'NAME=polipo' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo 'DESC=polipo' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '. /lib/lsb/init-functions' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '## Uncomment to include defaults if available' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '#if [ -f /etc/default/$NAME ]; then' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '#	. /etc/default/$NAME' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '#fi' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '## Make sure /var/run/polipo exsists' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo 'if [ ! -e /var/run/$NAME ]; then' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	mkdir -p /var/run/$NAME' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	chown proxy:proxy /var/run/$NAME' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	chmod 755 755 /var/run/$NAME' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo 'fi' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo 'case $1 in' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	start)' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		echo -n "Starting $DESC: "' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		$PPCTL start' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		## Or try un-commenting bellow if above does Not work' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo "		#\$NAME -c ${_polipo_dir}/polipo/config" | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		echo "$NAME."' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	;;' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	stop)' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		echo -n "Stoping $DESC: "' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		$PPCTL stop' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		echo "$NAME."' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	;;' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	status)' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	status_of_proc /usr/bin/$NAME $NAME' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	;;' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	#reload)' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		#	If the daemon can reload its config files on the fly' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		#	for example by sending it SIGHUP, do it here' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		#	If the daemon responds to changes in its config file anyway.' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		#	Then make this a do-nothing entry' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		#echo "Reloading $DESC configuration files."' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		#start-stop-daemon --stop --signal 1 --quiet --pidfile /var/run/$NAME.pid --exec $DAEMON' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	#;;' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	restart|force-reload)' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		#	If the "reload" is implemented, move the "force-reload" option' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		#	to the "reload" entry above. If not, "force-reload" is just' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		#	the same as "restart".' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		echo -n "Restarting $DESC: "' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		$PPCTL stop' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		sleep 1' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		$PPCTL start' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		echo "$NAME"' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	;;' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	*)' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo "		N=${_polipo_dir}/init.d/\$NAME" | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		#echo "Usage: $N (start|stop|reload|restart|force-reload)" >&2' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		echo "Usage: $N (start|stop|restart|force-reload)" >&2' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '		exit 1' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo '	;;' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo 'esac' | sudo tee -a ${_polipo_dir}/init.d/polipo
	echo 'exit 0' | sudo tee -a ${_polipo_dir}/init.d/polipo
#	echo '' | sudo tee -a ${_polipo_dir}/init.d/polipo
#	echo "" | sudo tee -a ${_polipo_dir}/init.d/polipo
}
### Polipo_init_client_help polipo_init_client_help polipo_init_client.sh
#	File:	${_script_dir}/functions/polipo/init_scripts/polipo_init_client.sh
####
## Run polipo with specified config (note "damonise = true" neads set within polipo config file)
# polipo -c ${_polipo_dir}/polipo/config
