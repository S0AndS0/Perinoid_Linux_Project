Write_iptables_multiport_action(){
	Arg_checker "${@:---help='Write_iptables_multiport_action' --exit='# Write_iptables_multiport_action # failed to be read arguments'}" -ep='Write_iptables_multiport_action'
	_action_name="${_fail2ban_dir:-/etc}/fail2ban/actions.d/iptables-multiport-persistance.conf"
	Overwrite_config_checker "${_action_name}"
	echo '# Fail2ban configuration file' | sudo tee -a ${_action_name}
	echo '#' | sudo tee -a ${_action_name}
	echo '# Author: Phil Hagen <phil@identityvector.com>' | sudo tee -a ${_action_name}
	echo '#' | sudo tee -a ${_action_name}
	echo '[Definition]' | sudo tee -a ${_action_name}
	echo '# Option:  actionstart' | sudo tee -a ${_action_name}
	echo '# Notes.:  command executed once at the start of Fail2Ban.' | sudo tee -a ${_action_name}
	echo '# Values:  CMD' | sudo tee -a ${_action_name}
	echo 'actionstart = iptables -N fail2ban-REPEAT-<name>' | sudo tee -a ${_action_name}
	echo '              iptables -A fail2ban-REPEAT-<name> -j RETURN' | sudo tee -a ${_action_name}
	echo '              iptables -I INPUT -j fail2ban-REPEAT-<name>' | sudo tee -a ${_action_name}
	echo '              # set up from the static file' | sudo tee -a ${_action_name}
	echo '              cat /etc/fail2ban/ip.blocklist.<name> |grep -v ^\s*#|awk '{print $1}' | while read IP; do iptables -I fail2ban-REPEAT-<name> 1 -s $IP -j DROP; done' | sudo tee -a ${_action_name}
	echo '# Option:  actionstop' | sudo tee -a ${_action_name}
	echo '# Notes.:  command executed once at the end of Fail2Ban' | sudo tee -a ${_action_name}
	echo '# Values:  CMD' | sudo tee -a ${_action_name}
	echo 'actionstop = iptables -D INPUT -j fail2ban-REPEAT-<name>' | sudo tee -a ${_action_name}
	echo '             iptables -F fail2ban-REPEAT-<name>' | sudo tee -a ${_action_name}
	echo '             iptables -X fail2ban-REPEAT-<name>' | sudo tee -a ${_action_name}
	echo '# Option:  actioncheck' | sudo tee -a ${_action_name}
	echo '# Notes.:  command executed once before each actionban command' | sudo tee -a ${_action_name}
	echo '# Values:  CMD' | sudo tee -a ${_action_name}
	echo 'actioncheck = iptables -n -L INPUT | grep -q fail2ban-REPEAT-<name>' | sudo tee -a ${_action_name}
	echo '# Option:  actionban' | sudo tee -a ${_action_name}
	echo '# Notes.:  command executed when banning an IP. Take care that the' | sudo tee -a ${_action_name}
	echo '#          command is executed with Fail2Ban user rights.' | sudo tee -a ${_action_name}
	echo '# Tags:    <ip>  IP address' | sudo tee -a ${_action_name}
	echo '#          <failures>  number of failures' | sudo tee -a ${_action_name}
	echo '#          <time>  unix timestamp of the ban time' | sudo tee -a ${_action_name}
	echo '# Values:  CMD' | sudo tee -a ${_action_name}
	echo 'actionban = iptables -I fail2ban-REPEAT-<name> 1 -s <ip> -j DROP' | sudo tee -a ${_action_name}
	echo '            # also put into the static file to re-populate after a restart' | sudo tee -a ${_action_name}
	echo '            ! grep -Fq <ip> /etc/fail2ban/ip.blocklist.<name> && echo "<ip> # fail2ban/$( date '+%%Y-%%m-%%d %%T' ): auto-add for repeat offender" >> /etc/fail2ban/ip.blocklist.<name>' | sudo tee -a ${_action_name}
	echo '# Option:  actionunban' | sudo tee -a ${_action_name}
	echo '# Notes.:  command executed when unbanning an IP. Take care that the' | sudo tee -a ${_action_name}
	echo '#          command is executed with Fail2Ban user rights.' | sudo tee -a ${_action_name}
	echo '# Tags:    <ip>  IP address' | sudo tee -a ${_action_name}
	echo '#          <failures>  number of failures' | sudo tee -a ${_action_name}
	echo '#          <time>  unix timestamp of the ban time' | sudo tee -a ${_action_name}
	echo '# Values:  CMD' | sudo tee -a ${_action_name}
	echo 'actionunban = /bin/true' | sudo tee -a ${_action_name}
	echo '[Init]' | sudo tee -a ${_action_name}
	echo '# Defaut name of the chain' | sudo tee -a ${_action_name}
	echo 'name = REPEAT' | sudo tee -a ${_action_name}
}
### Write_iptables_multiport_action_help write_iptables_multiport_action_help write_iptables_multiport_action.sh
#	File : ${_script_dir}/functions/fail2ban/actions_writers/write_iptables_multiport_action.sh
#	Option | Variable | Default | Notes
#	-------|----------|---------|------
#	-F2BD= | _fail2ban_dir | /etc | Sets base directory to look for [/etc/fail2ban]
#
#	Notes : this action is activated with the following line in ${_fail2ban_dir:-/etc}/fail2ban/jail.local
#	banaction = iptables-multiport
####
