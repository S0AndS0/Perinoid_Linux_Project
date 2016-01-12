#	Quick Start: help
## Clone source script pack
# git clone https://...
## Change directories to new directory made by git
# cd Perinoid_Linux
## Provide exicutable permissions to script
# chmod +x Sancastle.sh
## Print help documentation for script
# bash Perinoid --help
## Print help documentation for spiciffic function(s)
# bash Sandcastle.sh --help='Source_tor_functions'
# bash Sandcastle.sh --help='Check_host_enviroment,Arg_checker,default_variables'
## Install Tor as client with privoxy squid and bind9 local DNS server
# bash Perinoid --var-file='client_tor_install_vars.sh'

## Welcome to the Perinoid Linux project; the aims of which are simple, to build sandcastles against
#	tides that atempt to wash away privacy. Thanks should be given to those that aided in this
#	script pack's development, links to those documents that where interagle in educating the
#	authors of this script can be found within the [info] directory. 
## What does this script do?
#	Simplely put, this a installation and configuration script bundle that is inspired from Whonix
#	and other virtualization tecniques for security and compartimintalization.
#	This script accepts agruments in the form of [-arg='...'] or [--argument='...']
#	and if understood preforms the commanded action. If a command is not understood errors and
#	helpfull documentation will display to aid users in compleating the installation processes
#	next time around. Pipes maybe used such as [-arg="$(comand)"] by sourounding the piped command
#	with dubble quotes. Additionally entire variable files maybe loaded via [-vf=/path/to/vars] or
#	[--var-file=/path/to/vars] to avoid having to learn this scirpt's sytax for other arguements.
#	Tor, firejail, firetools, nginx, privoxy, polipo, squid, bind9 are all currently available to
#	install or re-configure through the use of [-A=application] or [-A=app1,app2] option and sellecting
#	installation method maybe chosen via [-I=source] or [-I=apt-get] or [-I=safe] or [-I=experoment]
#	options.
## What does this script not do?
#	It does not check host system for vurnablilaties or malware, nore does it make any geronty of
#	increesed security or privacy. In fact depending on arguments passed you make make your
#	location easier to obtain, ie running an exit or bridge Tor node publishes your externall
#	IP address to others that nead to connect. This is because "privacy" and "anyonimity" are
#	goals with many ends. Some users of these networks are more conserned with helping others acheive
#	privacy so will run a bridge, exit, or relay depending upon prefferances and leagal ramifacations
#	others are more conserned with personal privacy or anonimity of freinds so will instead
#	opt for client or private bridge setup.


## Notes to editors, authors, and source code readers.
#	This script pack is written in plain bash scripting language, much effort
#	has been taken to keep base system requriements to just BusyBox at bair minimum.
#	Most logics are handled through [case], [if], and [for] loops/checks to keep
#	readabilaty relotively easy, nearly all variable names discribe what types of values
#	should be contained. Every file name is a reflection of the function that it conatains
#	ie [source_tor_functions.sh] file contains one function named [Source_tor_functions]
#	and evry function has help documentation spicific to that script's function just bellow.
#	Nearly all the "heavy-lifting" for argument processing is preformed though [Arg_checker]
#	function and all variables assigned by this function can be found refferanced in
#	[blank_torinstall_vars.sh] file with documentation. When first diving into the source code
#	be aware of how these functions and values are assigned and you will hopefully have an easy
#	time making additions. The [-vf=...] or [--var-file=...] argument maybe used to test both
#	variable assignments as well as individual functions when combined with [-ep=...] or
#	[--external-parse=...] argument to bypass normal [Order_tor_install] function and other
#	functions that would normally be fired. Here's an example for positional arguments, ie [-arg=...]
#	say you wish to add a hidden authorized cookie to all client files for ssh client conncetion named
#	(anon_ssh) to an onion domanin named (domain.onion) to server connectioned (listening) over Tor
## Script example_ssh1 start
#	#!/bin/bash
#	source ${_script_dir}/functions/shared/source_shared_functions.sh
#	source ${_script_dir}/functions/tor/source_tor_functions.sh
#	Source_shared_functions "${_script_dir}"
#	Source_tor_functions "${_script_dir}"
#	Ssh_tor_client_configs "${@:---help='Ssh_tor_client_configs' --exit='# [Ssh_tor_client_configs] # Failed to be read args'}"
## Script example_ssh1 end
#	Call above "example_ssh" script with the following arguments.
## -C=8 -HAC='hId3n AutH C0oki3 valu3' -SHN='anon_ssh' -SHD='domain.onion' -ep='Ssh_tor_client_configs'
#
#	Alternitivley, using the [-vf=...] to assigne a variable file the same can be achieved with
## Script example_ssh2 start
#	#!/bin/bash
#	source ${_script_dir}/functions/shared/source_shared_functions.sh
#	source ${_script_dir}/functions/tor/source_tor_functions.sh
#	Source_shared_functions "${_script_dir}"
#	Source_tor_functions "${_script_dir}"
#	Ssh_tor_client_configs -vf=/path/to/var/ssh_var_file -ep=ssh_example
## Script example_ssh2 end
#	In which case your [ssh_var_file] should contain the fallowing variable assignments
## ssh_var_file example start
#	_connection_count='8'
#	_hidden_auth_cookie='hId3n AutH C0oki3 valu3'
#	_ssh_host_name='anon_ssh'
#	_ssh_host_domain='domain.onion'
## ssh_var_file example end
## Script example_general_use1 start
#	#!/bin/bash
#	${_script_name} -A='NULL'
#	## For example_ssh1
#	#Ssh_tor_client_configs -C=8 -HAC='hId3n AutH C0oki3 valu3' -SHN='anon_ssh' -SHD='domain.onion' -ep='Ssh_tor_client_configs'
#	## For example_ssh2
#	#Ssh_tor_client_configs -vf=/path/to/var/ssh_var_file -ep=ssh_example
#	## Passing [-A='NULL'] will casue ${_script_name} to load all available functions and allow further
#	#	processing, in fact this allows users to pass "one-liners" to ${_script_name} if thoughtfully
#	#	constructed.
## Script example_general_use1 end
## Script example_one_liner1 start
#	${_script_name} -A='NULL' && Ssh_tor_client_configs -C=8 -HAC='hId3n AutH C0oki3 valu3' -SHN='anon_ssh' -SHD='domain.onion' -ep='Ssh_tor_client_configs'
## Script example_one_liner1 end
#
#	Most functions maybe loaded this way such that indiividual features can be exposed
#	and used latter without effecting current installation. This allows for much easier
#	testing of new features if writing a new function or making modifications to a current
#	functions. Spend some time with the help documentation for more info on incorperating mods.
