Write_nginx_server_block(){
	Arg_checker "${@:---help='Write_nginx_server_block' --exit='# [Write_nginx_server_block] # Failed to be read arguments'" -ep='Write_nginx_server_block'
	_nginx_ports="${_nginx_http_port},${_nginx_ssl_port}"
	_nginx_index_dir="${_tor_web_dir}/${_nginx_service_name}"
	_nginx_index_file="${_nginx_index_dir}/${_nginx_index}"
	_nginx_config_file="${_nginx_dir}/nginx/sites-available/${_nginx_service_name}"
	if ! [ -d "${_nginx_index_dir" ]; then
		echo '## Notice [Write_nginx_server_block] detected no directory'
		echo "#	under [${_nginx_index_dir}]"
		echo '#	Fixing that now.'
		sudo mkdir -p "${_nginx_index_dir}"
	fi
	if ! [ -f "${_nginx_index_file}" ]; then
		echo '## Notice [Write_nginx_server_block] detected no index.html file'
		echo "#	at [${_nginx_index_file}]"
		echo '#	Fixing that now.'
		echo '<html>' sudo tee -a ${_nginx_index_file}
		echo '<head>' sudo tee -a ${_nginx_index_file}
		echo '<title>Hidden Service Online</title>' sudo tee -a ${_nginx_index_fle}
		echo '</head>' sudo tee -a ${_nginx_index_file}
		echo '<body>' sudo tee -a ${_nginx_index_file}
		echo '<h1>Hidden Service Online</h1>' sudo tee -a ${_nginx_index_file}
		echo '</body>' sudo tee -a ${_nginx_index_file}
		echo '</html>' sudo tee -a ${_nginx_index_file}
	fi
	echo "## Notice [Write_nginx_server_block] ensuring permissions are set correctly"
	echo "#	for [${_nginx_index_dir}] and [${_tor_web_dir}]"
	sudo chown -R www-data:www-data ${_nginx_index_dir}/
	sudo chmod 755 ${_tor_web_dir}
	Overwrite_config_checker "${_nginx_dir}/nginx/sites-available/${_nginx_service_name}"
	echo "## Notice [Write_nginx_server_block] now writing new nginx service_block file"
	_search_http=$(grep -E '80' <<<${_nginx_port})
	_search_ssl=$(grep -E '443' <<<${_nginx_port})
	for _nginx_port in ${_nginx_ports//,/ }; do
		if [ "${#_search_http}" != "0" ]; then
			echo 'server {' | sudo tee -a ${_nginx_config_file}
			echo '	add_header Cache-Control "public";' | sudo tee -a ${_nginx_config_file}
			echo "	access_log /var/log/nginx/access_${_nginx_url}_.log;" | sudo tee -a ${_nginx_config_file}
			echo "	error_log /var/log/nginx/error_${_nginx_url}_.log;" | sudo tee -a ${_nginx_config_file}
			echo '	expires max;' | sudo tee -a ${_nginx_config_file}
			echo '	limit_req zone=gulag burst=200 nodelay;' | sudo tee -a ${_nginx_config_file}
			echo "	listen 127.0.0.1:${_nginx_port};" | sudo tee -a ${_nginx_config_file}
			if [ "${#_search_ssl}" = "0" ]; then
				echo "	root ${_nginx_web_dir}/${_nginx_dir_name}/;" | sudo tee -a ${_nginx_config_file}
				echo "	${_nginx_index} index index.html index.htm;" | sudo tee -a ${_nginx_config_file}
			elif [ "${#_search_ssl}" != "0" ]; then
				echo '	root /var/empty;' | sudo tee -a ${_nginx_config_file}
				echo "	return 301 https://${_nginx_url}\$url;" | sudo tee -a ${_nginx_config_file}
			fi
			echo "	server_name ${_nginx_url};" | sudo tee -a ${_nginx_config_file}
			if [ "${#_search_ssl}" != "0" ]; then
				echo "## Notice [Write_nginx_server_block] detected SSL port [${_nginx_port}]"
				echo '}' | sudo tee -a ${_nginx_config_file}
			else
				echo "## Notice [Write_nginx_server_block] detected NO SSL port [${_nginx_port}]"
				echo "#	skipping that section and wrapping up with [if] statments..."
			fi
		fi
		if [ "${#_search_ssl}" != "0" ]; then
			echo "## Notice [Write_nginx_server_block] now writing SSL port [${_nginx_port}] server_block"
			echo 'server {' | sudo tee -a ${_nginx_config_file}
			echo "	listen 127.0.0.1:${_nginx_port};" | sudo tee -a ${_nginx_config_file}
			echo '	add_header Cache-Control "public";' | sudo tee -a ${_nginx_config_file}
			echo '	add_header X-Content-Type-Option "nosniff";' | sudo tee -a ${_nginx_config_file}
			echo '	add_header X-Frame-Options "DENY";' | sudo tee -a ${_nginx_config_file}
			echo '	add_header Strict-Transport-Security "max-age=315360000; includeSubdomains";' | sudo tee -a ${_nginx_config_file}
			echo "	access_log /var/log/nginx/access_${_nginx_url}_.log main;" | sudo tee -a ${_nginx_config_file}
			echo '	error_log /var/log/nginx/error_${_nginx_url}_.log info;' | sudo tee -a ${_nginx_config_file}
			echo '	expires max;' | sudo tee -a ${_nginx_config_file}
			echo "	${_nginx_index} index index.html;" | sudo tee -a ${_nginx_config_file}
			echo '	limit_req zone=gulag burst=200 nodelay;' | sudo tee -a ${_nginx_config_file}
			echo "	listen 127.0.0.1:${_nginx_port} ssl spdy;" | sudo tee -a ${_nginx_config_file}
			echo "	root ${_nginx_web_dir}/${_nginx_dir_name}/;" | sudo tee -a ${_nginx_config_file}
			echo "	server_name ${_nginx_url} www.${_nginx_url};" | sudo tee -a ${_nginx_config_file}
			echo '	ssl on;' | sudo tee -a ${_nginx_config_file}
			echo '	ssl_session_cache shared:SSL:1m;' | sudo tee -a ${_nginx_config_file}
			echo "	#ssl_certificate /ssl_keys/${_nginx_url}.crt;" | sudo tee -a ${_nginx_config_file}
			echo "	#ssl_certificate_key /ssl_keys/${_nginx_url}.key;" | sudo tee -a ${_nginx_config_file}
			echo '	ssl_stapling on;' | sudo tee -a ${_nginx_config_file}
			echo '	ssl_stapling_verify on;' | sudo tee -a ${_nginx_config_file}
		fi
		echo "#	Wrapping up server block..."
		echo '	## Redirect from www to non-www (strips args with question [?] marks)' | sudo tee -a ${_nginx_config_file}
		echo "	if (\$host "'!='" '${_nginx_url}') { return 301 https://${_nginx_url}\$url; }" | sudo tee -a ${_nginx_config_file}
		echo '	## Available Methods Restrictions' | sudo tee -a ${_nginx_config_file}
		echo '	if ($request_method !~ ^(GET|HEAD|POST)$ ) { return 444; }' | sudo tee -a ${_nginx_config_file}
		echo '	## Domain Access Restrictions' | sudo tee -a ${_nginx_config_file}
		echo "	if (\$host "'!~'" ^{${_nginx_url}|www.${_nginx_url})\$ ) { return 444; }" | sudo tee -a ${_nginx_config_file}
		echo '	## User-Agent Restrictions' | sudo tee -a ${_nginx_config_file}
		echo '	if ($http_user_agent ~* (Simple|BBBike|wget|Baiduspider|Jullo)) { return 403; }' | sudo tee -a ${_nginx_config_file}
		echo '	## Referral Spam Restrictions' | sudo tee -a ${_nginx_config_file}
		echo '	if ($http_referer ~* (babes|forsale|girl|jewelry|love|nudit|organic|poker|porn|sex|teen|video|webcam|zippo)) { return 403; }' | sudo tee -a ${_nginx_config_file}
		echo '	## Image Hotlinking Restrictions (option 1)' | sudo tee -a ${_nginx_config_file}
		echo '	#location ~* (\.jpg|\.png|\.css)$ {' | sudo tee -a ${_nginx_config_file}
		echo "	#	if (\$http_referer "'!~'" ^(http://${_nginx_url})) { 405; }" | sudo tee -a ${_nginx_config_file}
		echo '	#}' | sudo tee -a ${_nginx_config_file}
		echo '	## Image Hotlinking Restrictions (option 2)' | sudo tee -a ${_nginx_config_file}
		echo '	#location /images/ {' | sudo tee -a ${_nginx_config_file}
		echo "	#	valid_referers none blocked www.${_nginx_url} ${_nginx_url};" | sudo tee -a ${_nginx_config_file}
		echo '	#	if ($invalid_referer) { return 403; }' | sudo tee -a ${_nginx_config_file}
		echo '	#}' | sudo tee -a ${_nginx_config_file}
		echo '	## Image Hotlinking Restrictions (option 3)' | sudo tee -a ${_nginx_config_file}
		echo '	#lid_referes blocked www.example.com example.com' | sudo tee -a ${_nginx_config_file}
		echo '	#($invalid_referer) {' | sudo tee -a ${_nginx_config_file}
		echo '	#	rewrite ^/images/uploads. *\.(gif|jpg|jpeg|png)$ http://www.examples.com/banned.jpg last' | sudo tee -a ${_nginx_config_file}
		echo '	#}' | sudo tee -a ${_nginx_config_file}
		echo '	## IP Address Restricted Directory /docs/ (option 1)' | sudo tee -a ${_nginx_config_file}
		echo '	#location /docs/ {' | sudo tee -a ${_nginx_config_file}
		echo '	#	## Block one workstation' | sudo tee -a ${_nginx_config_file}
		echo '	#	deny	192.168.1.1;' | sudo tee -a ${_nginx_config_file}
		echo '	#	## Allow local NAT' | sudo tee -a ${_nginx_config_file}
		echo "	#	allow ${_range_ipv4};" | sudo tee -a ${_nginx_config_file}
		echo '	#	## Drop all other addresses' | sudo tee -a ${_nginx_config_file}
		echo '	#	deny all;' | sudo tee -a ${_nginx_config_file}
		echo '	#}' | sudo tee -a ${_nginx_config_file}
		echo '	## IP Address Restricted Directory /secure/ (option 2)' | sudo tee -a ${_nginx_config_file}
		echo '	#location ^~ /secure/ {' | sudo tee -a ${_nginx_config_file}
		echo '	#	allow 127.0.0.1/32;' | sudo tee -a ${_nginx_config_file}
		echo "	#	allow ${_range_ipv4};" | sudo tee -a ${_nginx_config_file}
		echo '	#	deny all;' | sudo tee -a ${_nginx_config_file}
		echo '	#	auth_basic "RESTRICTED ACCESS";' | sudo tee -a ${_nginx_config_file}
		echo "	#	auth_basic_user_file /var/www/htdocs/secure/access_list;" | sudo tee -a ${_nginx_config_file}
		echo '	#}' | sudo tee -a ${_nginx_config_file}
		echo '	## Robot Blocking Restructions' | sudo tee -a ${_nginx_config_file}
		echo '	if ($http_user_agent ~* msnbot|scrapbot ) { return 403; }' | sudo tee -a ${_nginx_config_file}
		echo '	## Serve empty 1x1 gif _OR_ and error 204 (No Content) for faveicon.ico' | sudo tee -a ${_nginx_config_file}
		echo '	location = /faveicon.ico { return 204; }' | sudo tee -a ${_nginx_config_file}
		echo '	## Default location with System Maintenance (Service Unavailable) check' | sudo tee -a ${_nginx_config_file}
		echo '	location / { try_files system_maintenance.html $uri $uri/ =404; }' | sudo tee -a ${_nginx_config_file}
		echo '	## All other errors get generic error page' | sudo tee -a ${_nginx_config_file}
		echo '	error_page 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 495 496 497 500 501 502 503 504 505 506 507 /error_page.html;' | sudo tee -a ${_nginx_config_file}
		echo '	location /error_page.html { internal; }' | sudo tee -a ${_nginx_config_file}
		echo '	## Simultaneous Connection Restrictions' | sudo tee -a ${_nginx_config_file}
		echo '	limit_zone slimits $binary_remote_addr 5m;' | sudo tee -a ${_nginx_config_file}
		echo '	limit_conn slimits 7;' | sudo tee -a ${_nginx_config_file}
		echo '}' | sudo tee -a ${_nginx_config_file}
	done
	echo '## Notice [Write_nginx_server_block] now providing symbolic link to [~/sites-enabled/] nginx sub-directory'
	sudo ln -s ${_nginx_config_file} ${_nginx_dir}/nginx/sites-enabled/${_nginx_service_name}
	echo "#	Restarting nginx services to activate, you should be able to access your new services via [${_nginx_url}]"
	sudo service nginx restart
#echo '' | sudo tee -a ${_nginx_config_file}
#echo "" | sudo tee -a ${_nginx_config_file}
#echo "" sudo tee -a ${_nginx_config_index}
#echo '' sudo tee -a ${_nginx_config_index}
}
### Write_nginx_server_block_help write_nginx_server_block_help write_nginx_server_block.sh
#	File:	${_script_dir}/functions/nginx/config_nginx/write_nginx_server_block.sh
#	Generally only activated if [${_script_name}] detects [-T="service-auth:web,open:web,open:mirror"] options
#	used to generate server_block files for nginx and a default [index.html] file.
#	Arguments used (inherited) from [${_script_name}] run-time
#	Argument	Value			Default
#	[-ND]		${_nginx_dir}		/etc
#	[-NHP] 		${_nginx_http_port}	8080
#	[-NSP]		${_nginx_ssl_port}	8443
#	Arguments used by [#{_script_name}] to assigne variables during internall run-time
#	[-NSN]		${_nginx_service_name}	No default; set by [Order_tor_install] internally
#	[-NI]		${_nginx_index}		index.html
#	[-NU]		${_nginx_user}		nginx
####
