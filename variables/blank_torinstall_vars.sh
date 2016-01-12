## Note [$_tor_application_list] from [Arg_checker] normally is fead into bellow variable
_application_list=""
_apt_target_release=""
_arg_check_count=""
_auto_yn=""
_btc_address=""
_bridge_ipv4_to_add=""
_bridge_ipv6_to_add=""
_bridge_finger_print_to_add=""
_bridge_type_to_add=""
_bridge_port_to_add=""
_bind9_dir=""
_bind9_user=""
_bind9_ipv4=""
_bind9_port=""
_connection_count=""
_email_address=""
_enable_ipv6=""
_external_ipv4=""
_external_ipv6=""
_external_parse=""
_firejail_dir=""
_firejail_bridge_interface=""
_firejail_bridge_ipv4=""
_firejail_bridge_forward=""
_firejail_host_interface=""
_firejail_nat_ipv4=""
_firejail_service_name=""
_hidden_auth_cookie=""
_install_method=""
_nat_ipv4=""
_nat_ipv6=""
_nginx_dir=""
_nginx_index=""
_nginx_http_port=""
_nginx_service_name=""
_nginx_ssl_port=""
_nginx_url=""
_openssh_port=""
_passwd=""
_privoxy_dir=""
_privoxy_user=""
_polipo_dir=""
_polipo_user=""
_range_ipv4=""
_ssh_host_name=""
_ssh_host_domain=""
_squid_dir=""
_squid_user=""
_temp_dir=""
_tor_user=""
_tor_directory=""
_tor_node_types=""
_tor_bridge_nickname=""
_tor_exit_nickname=""
_tor_relay_nickname=""
_tor_relay_bandwidth_rate=""
_tor_relay_bandwidth_burst=""
#_tor_service_nickname=""
_tor_web_dir=""
_tor_service_clients=""
_tor_or_port=""
_tor_ssh_port=""
_tor_web_port=""
_bridge_types=""
_client_types=""
_exit_types=""
_relay_types=""
_service_types=""
### Blank_torinstall_vars_help blank_torinstall_vars_help blank_torinstall_vars.sh
#	File: ${_script_dir}/functions/tor/sample_vars/blank_torinstall_vars.sh
#	Variables Explained
## _application_list			# Set by [-A=...] argument to [${_script_name]
#		Default:	tor,tor-arm,tor-geoipdb,deb.torproject.org-keyring
#		Uses:		overwrites packages to install, use above deafaults in addition
#				to avoid errors from missing packages.
## _apt_target_release			# Set by [-AT=...] argument to [${_script_name]
#		Default:	No default
#		Uses:		Set internally during script run time to dictate where packages
#				should be installed updated as well as what value is writen in
#				[/etc/apt/preferances.d/] directory. This allong with supporting
#				functions enables the apt-get source list mangling without leaving
#				system toatly unusable to user.
## _arg_check_count			# Set by calling [Arg_checker] with arguments
#		Default:	0
#		Uses:		Internally set and used by [${_script_name}] to expose run time logic
#				as each function is called. Few functions such as will make use of this
#				variable internally but only on ocasions that these functions do not
#				make use of the [Arg_checker] function to set any variables.
## _auto_yn				# Set by [-AY=...]
## _bridge_ipv4_to_add			# Set by [-ABipv4=...] argument to [${_script_name]
#		Default:	no input no bridge
#		Uses:		Writes properly formatted line into torrc client files restricting
#				tor client connections to utilize bridge's IPv4 address
## _bridge_ipv6_to_add			# Set by [-ABipv6=...] argument to [${_script_name]
#		Default:	no input no bridge
#		Uses:		Writes properly formatted line into torrc client files restricting
#				tor client connections to utilize bridge's IPv6 address
## _bridge_finger_print_to_add		# Set by [-ABf=...] argument to [${_script_name]
#		Default:	no input no bridge
#		Uses:		Writes properly formatted line into torrc client files restricting
#				tor client connections to utilize bridge's IPv4 or IPv6 address that
#				also inclued finger print. Usually for obsf3 type bridges
## _bridge_type_to_add			# Set by [-ABt=...] argument to [${_script_name]
#		Default:	no input no bridge
#		Uses:		Writes properly formatted line into torrc client files restricting
#				tor client connections to utilize bridge types such as obsf3
## _bridge_port_to_add			# Set by [-ABp=...] argument to [${_script_name]
#		Default:	no input no bridge
#		Uses:		Writes properly formatted line into torrc client files restricting
#				tor client connections to utilize bridge port
## _btc_address				# Set by [-BA=...] argument to [${_script_name]
#		Default:	no input no BTC address added to contact info
#		Uses:		Sets btc address in torrc contact info fields for non-client
#				installations
## _bind9_dir				# Set by [-B9D=...] argument to [${_script_name]
#		Default:	/etc
#		Uses:		
## _bind9_user				# Set by [-B9U=...] argument to [${_script_name]
#		Default:	
#		Uses:		
## _bind9_ipv4				# Set by [-B9ipv4=...] argument to [${_script_name}]
#		Default:	127.0.0.1
#		Uses:		
## _bind9_port				# Set by [-B9P=...] argument to [${_script_name}]
#		Default:	53
#		Uses:		
## _connection_count			# Set by [-C=...] argument to [${_script_name]
#		Default:	8
#		Uses:		Writes number of client configured torrc and pid files as well as
#				setting up firewall rules for load balacing between.
## _email_address			# Set by [-EA=...] argument to [${_script_name}]
#		Default:	no email, no email written to contact info
#		Uses:		Writes email address to torrc configuration files for non-client options
## _enable_ipv6				# Set by [-ipv6=...] argument to [${_script_name]
#		Default:	no
#		Uses:		Writes torrc configruations enabling IPv6 addresses for variase
#				tor node types; bridge, client, exit, relay and available sub-types
#				are all effected by this setting currently so be cairfull
## _external_ipv4			# Set by [-Eipv4=...] argument to [${_script_name]
#		Default:	Check [opendns.org] after prompt if empty
#		Uses:		Required for tor node types; bridge, exit, relay
## _external_ipv6			# Set by [-Eipv6=...] argument to [${_script_name]
#		Default:	no default; experimental
#		Uses:		Not currently used but latter versions my enable configuration
#				of tor node types; bridge, exit, relay
## _external_parse			# Set by [-ep=...] argument to [${_script_name]
#		Default:	1 or function's name
#		Uses:		Internally used by [${_script_name}] to set what prompts are
#				displaid during [Arg_checker_tor] function's run time. This may also
#				be used latter by authors of plugins that wish to make use of functions
#				or variables available via [${_script_name}] combined with setting
#				[-vf=...] argument and many interesting scripts maybe written to further
#				expand on what [${_script_name}] does on it's own. By default this value
#				starts set to [1] and then is set by each function to that function's name
#				such that [Arg_checker_tor] function will print a counter allong with
#				calling function's name prior to allowing that function to further process
#				it's subsiquent variables. This "hot-potato" action makes for an easire
#				expireance when making modifications as errors or anomalies during
#				[${_script_name}] run-time can be tracked back.
## _firejail_dir			# Set by [-FD=...] argument to [${_script_name}]
#		Default:	/etc
#		Uses:		
## _firejail_service_name		# Set by [-FSN=...] argument to [${_script_name}]
#		Default:	nginx
#		Uses:		
## _firejail_bridge_interface		# Set by [-FBI=...] argument to [${_script_name}]
#		Default:	br0
#		Uses:		
## _firejail_host_interface		# Set by [-FHI=...] argument to [${_script_name}]
#		Default:	eth0
#		Uses:		
## _firejail_bridge_ipv4		# Set by [-FBipv4=...] argument to [${_script_name}]
#		Default:	10.10.20.1
#		Uses:		
## _firejail_nat_ipv4		# Set by [-FNipv4=...] argument to [${_script_name}]
#		Default:	10.10.20.0
#		Uses:		
## _firejail_bridge_forward	# Set by [-FBF=...] argument to [${_script_name}]
#		Default:	enabled
#		Uses:		
## _hidden_auth_cookie			# Set by [-HAC=...] argument to [${_script_name}]
#		Default:	no default, if not set then not written
#		Uses:		Writes hidden authintication token to each client torrc file via [-C=...]
#				Only activated if setting up client via [-T="client"] option and ssh
#				client files to [${HOME}/.ssh] directory for [-SHN=...] and [-SHD=...]
#				options.
## _install_method			# Set by [-I=...] argument to [${_script_name]
#		Default:	aptget
#		Uses:		Alternetively [-I=source] maybe used though that will install [tor] or other
#				packages from github zip file or developer hosted tar file. Note in some cases
#				there maybe missing dependancies while using [source] as an option, so
#				[${_script_name}] also provides [-I=safe] and [-I=experoment] to define installing
#				using the safest or most experomental aproch; mainly usefull for firejail install
## _nat_ipv4				# Set by [-Lipv4=...] argument to [${_script_name]
#		Default:	first live IPv4 address (usually eth0)
#		Uses:		Nearlly all tor node types utilize this address at somepoint
#				this should set itself automaticly but for systems with more than
#				one IPv4 address or mmore than one network interface should set this
#				if an differant IPv4 address is desired. As this uses [ip addr] command
#				piped though [grep] and [awk] it should not pose a privacy risk to
#				leave blank and let [${_script_name}] set things up.
## _nat_ipv6			# Set by [-Lipv6=...] argument to [${_script_name]
#		Default:	no default, no auto values
#		Uses:		Not used currently but latter versions may make use of this
#				variable much like [-Lipv4] argument
## _nginx_dir				# Set by [-ND=...] argument to [${_script_name}]
#		Default:	/etc
#		Uses:		Change where [${_script_name}] should look for nginx configuration
#				files sub-directory. Expands out to [/etc/nginx] during runtime.
#				Used only if a web server is requred for serving exit notices or
#				if [-T=service-auth:web,open:web,open:mirror] options are detected
#				by [${_script_name}]
## _nginx_index				# Set by [-NI=...] argument to [${_script_name}]
#		Default:	index.html
#		Uses:		Ste internally during [${_script_name}] run-time and not usefull
#				unless modifing the [Write_nginx_server_block] function as well
## _nginx_http_port			# Set by [-NHP=...] argument to [${_script_name}]
#		Default:	8080
#		Uses:		Set internally or inherited if changed, writes port to server_block
#				files as well as to torrc files that make use of Tor hidden
#				services options
## _nginx_service_name			# Set by [-NSN=...] argument to [${_script_name}]
#		Default:	Set internally to reflect hidden service type
#		Uses:		Maybe used externally, however, during normal script operation
#				this argument is set to either [open-web] or [auth-web]
## _nginx_ssl_port			# Set by [-NSP=...] argument to [${_script_name}]
#		Default:	8443
#		Uses:		Set internally or inherited if changed, writes port to server_block
#				future versions will make available self-signed ssl options or perhaps
#				free ssl cert provider if one can be found to be ~.onion friendly
## _openssh_port			# Set by [-OSP=...] argument to [${_script_name}]
#		Default:	22
#		Uses:		Change the OpenSSH server listening port writen to torrc files
#				only activated if [auth:ssh] or [open:ssh] are detected
## _privoxy_dir				# Set by [-PD=...] argument to [${_script_name}]
#		Default:	/etc
#		Uses:		Change directory to look for privoxy's configuration file sub-
#				directory. Not usefull to set unless setting privoxy to non-default
#				installation locations.
## _passwd				# Set by [-p=...] argument to  [${_script_name}]
#		Default:	12
#		Uses:		Accepts intigers and words, if intiger then each time a password neads
#				made then a random password is made of that length. If the argument is
#				not an itiger then when passwords are to be made the value contained
#				by this variable will be used without modification. This second option
#				should be used with care and not at all if setting up more advanced
#				configurations.
## _privoxy_user			# Set by [-PU=...] argument to  [${_script_name}]
#		Default:	privoxy
#		Uses:		Usefull if installing from source or if wanting to install privoxy
#				under a custom username. Safe to leave as is.
## _polipo_dir				# Set by [-PoD=...] argument to [${_script_name}]
#		Default:	/etc
#		Uses:		
## _polipo_user				# Set by [-PoU=...] argument to [${_script_name}]
#		Default:	polipo
#		Uses:		
## _ssh_host_name			# Set by [-SHN=...] argument to [${_script_name}]
#		Default:	no default, if not set then not written or used. Requires _ssh_host_domain value
#		Uses:		Writes value to [${HOME}/.ssh/ssh_config] file's [host \${_ssh_host_name}]
#				line. Allows for ssh client to issue [ssh \${_ssh_host_name}] to use Tor
#				client services for ssh remote connections. Note if [-HAC=...] was passed
#				at the same time then this ssh session will be setup with that auth cookie
#				into the related torrc client files
## _ssh_host_domain			# Set by [-SHD=...] arguments to [${_script_name}]
#		Default:	no default, if not set then not written or used. Requres _ssh_host_name value
#		Uses:		Writes value to [${HOME}/.ssh/ssh_config] file's [hostname \${_ssh_host_domain}]
#				line. Generally this is an ~.onion domain name and if the [-HAC...] value
#				was also asigned then this domain name will be tied to that auth cookie.
#				Note in future versions there will be options for setting a web host auth
#				cookie for browsing http(s) onion domains that make use of auth cookies.
## _squid_dir				# Set by [-SqD=...] argument to [${_script_name}]
#		Default:	/etc
#		Uses:		
## _squid_user				# Set by [-SqU=...] argument to [${_script_name}]
#		Default:	squid
#		Uses:		
## _temp_dir				# Set by [-t=...] argument to [${_script_name]
#		Default:	/tmp
#		Uses:		When [-I=source] then this directory path is used to make new
#				temperary directories for downloading and extracting source files
#				additionally this is where all logs will eventually be saved to
#				the host's system during [${_script_name}] run time
## _tor_user				# Set by [-U=...] argument to [${_script_name]
#		Default:	debian-tor
#		Uses:		Sets the user and group to install and configure all tor node
#				types. Best to leave as is unless you have good reason to deveate
## _tor_directory			# Set by [-TD=...] argument to [${_script_name]
#		Default:	/etc
#		Uses:		Sets base diretory to look for [torrc] configuration files allong
#				with where to look for [init.d] sub-directory for writing start/stop
#				scripts for the available tor node types. Expands out to [/etc/tor]
#				during [${_script_name}] run-time.
## _tor_node_types			# Set by [-T=...] argument to [${_script_name]
#		Default:	client
#		Uses:		Other values are: bridge, exit, or relay currently and these
#				maybe seperated by [#] signe to include more tor node types to setup
#				more than one type in one go, ie [client#bridge] will setup both
#				sub-options for; brdge, exit and relay are seperated by [-] signe
#				ie, [bridge-private#relay-public] will setup spicific lines in
#				torrc files related to each type to enable public or private repectively
#				by default the "safest" sub-option [private] if available will be
#				set if not set by user
## _tor_bridge_nickname			# Set by [-B=...] argument to [${_script_name]
#		Default:	bridge
#		Uses:		Sets name of [torrc-${_tor_bridge_nickname:-bridge}] file
#				and the name of init start/stop scripts. Much like tor node types
#				exit and relay users should refain from file names involving
#				spaces as this will cause errors latter on when tor services
#				atempt to load these files. Used only if [-T=bridge] is passed
## _tor_exit_nickname			# Set by [-E=...] argument to [${_script_name]
#		Default:	exit
#		Uses:		Sets name of torrc and init scripts much like bridge type
#				you will want to avoid spaces. Only used if [-T=exit] is passed
## _tor_relay_nickname			# Set by [-R=...] argument to [${_script_name]
#		Default:	relay
#		Uses:		See options for both bridge and exit nicknames. Only used
#				if [-T=relay] is passed
## _tor_relay_bandwidth_rate		# Set by [-Rbr=...] argument to [${_script_name}]
#				used within relay torrc configs
## _tor_relay_bandwidth_burst		# Set by [-Rbr=...] argument to [${_script_name}]
#				used within relay torrc configs
## _tor_web_dir				# Set by [-W=...] argument to [${_script_name]
#		Default:	/var/www/tor
#		Uses:		Sets tor types; exit and relay web directory for serving
#				tor exit notice html file. Latter versions of [${_script_name}]
#				may also make use of this value for setting up web servers and
#				hidden services.
## _tor_service_clients			# Set by [-TSC=...] argument to [${_script_name}]
#		Default:	${USER}
#		Uses:		Sets clients allowed to connect to "auth" based ssh and web
#				hidden services. Maybe coma serperated and writes to related
#				hidden service torrc files only if the service is also using
#				a cookie based authentication.
## _tor_or_port				# Set by [-TOP=...] argument to [${_script_name}]
#		Default:	443
#		Uses:		
## _tor_ssh_port			# Set by [-TSP=...] argument to [${_script_name}]
#		Default:	22422
#		Uses:		Sets ssh port for torrc hidden services OpenSSH server
## _tor_web_port			# Set by [-TWP=...] argument to [${_script_name}]
#		Default:	8080
#		Uses:		Sets the http web port for Tor hidden services and mirror torrc
#				Additionally this will be the pot forwarded by iptables
#_bridge_types
#_client_types
#_exit_types
#_relay_types
#_service_types
## _open_services
## _auth_services
## See [${_script_name} -h='Arg_checker_tor'] for more help on setting values
####
