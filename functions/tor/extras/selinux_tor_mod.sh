Selinux_tor_mod(){
	echo '## Notice [Selinux_tor_mod] function searching for [sestatus]'
	which sestatus
	if [ "$?" = "0" ]; then
		echo '#	Found [sestatus] command, now checking if disabled or not'
		sestatus | grep -oE "disabled"
		if [ "$?" != "0" ]; then
			echo '#	[sestatus] not disabled, adding tor permmissions to bind to unreserved ports'
			echo '#	[ semanage permissive -P tor_bind_all_unreserved_ports 1 ]'
			semanage permissive -P tor_bind_all_unreserved_ports 1
		else
			echo '#	[sestatus] is installed but disabled on your system!'
			echo '#	[Selinux_tor_mod] passing control back to calling function without adding'
			echo '#	Tor spicific rules, consider enabling [selinux] or purging to avoid this message.'
		fi
	else
		echo '#	No [sestatus] command found [Selinux_tor_mod] passing control back to calling function now.'
	fi

}
### Selinux_tor_mod_help selinux_tor_mod_help selinux_tor_mod.sh
#	File:	${_script_dir}/functions/tor/extras/selinux_tor_mod.sh
#	No arguments are processed externally by this function, instead it quickly checks if the host system
#	has selinux or not and if so if it is enabled or not. Messages will pop for each outcome and if
#	selinux is found to be enabled then the following command will run to enabled Tor services to bind to
#	unreserved ports
#		semanage permissive -P tor_bind_all_unreserved_ports 1
#	Otherwise this function does nothing but display text to [${USER}] during run-time, just before
#	configuring for verias Tor node types
####
