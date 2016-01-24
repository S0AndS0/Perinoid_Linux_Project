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
