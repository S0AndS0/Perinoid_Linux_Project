## Nginx server hardening tips #16
#	http://www.cyberciti.biz/tips/linux-unix-bsd-nginx-webserver-security.html
## Often found under /etc/php.ini
#	## Dissallow "dangerous" functions
#	disable_functions = phpinfo, system, mail, exec
#	## Resources Limitation
#	## Max execution time per script
#	max_execution_time = 30
#	## Max parsing request limit per script
#	max_input_time = 60
#	## Max memrory per script
#	memory_limit = 8M
#	## Max POST size PHP will accept
#	post_max_size = 8M
#	## Dissalow HTTP file uploads
#	file_uploads = Off
#	## Max upload file size
#	upload_max_filesize = 2M
#	## Disable PHP error messages to external clients
#	display_errors = Off
#	## Enable "Safe Mode"
#	safe_mode = On
#	## Enable exicutables in isolated directory
#	#safe_mode_exec_dir = php-required-executables-path
#	## Limit external access to PHP enviroment
#	safe_mode_allowed_env_vars = PHP_
#	## Restrict PHP info leakage
#	expose_php = Off
#	## Enable logging All errors
#	log_errors = On
#	## Disable globals for input data
#	register_globals = Off
#	## Minimize allowable PHP post size
#	post_max_size = 1K
#	## Fource PHP redirection appropriately
#	cgi.force_redirect = 0
#	## Nable SQL "Safe Mode"
#	sql.safe_mode = On
#	## Disable opening remote files
#	allow_url_fopen = Off

