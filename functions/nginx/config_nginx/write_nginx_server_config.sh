Write_nginx_server_config(){
	Arg_checker "${@:---help='Write_nginx_server_config' --exit='# [Write_nginx_server_config] # Failed to be read arguments'" -ep='Write_nginx_server_config'
	Overwrite_config_checker "$[_nginx_dir}/nginx/nginx.conf"
	echo "#	Notice [Write_nginx_server_config] now writing the following lines to [${_nginx_dir}/nginx/nginx.conf] file"
	echo 'user www-data;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo 'worker_processes 4;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo 'pid /run/nginx.pid;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo 'events {' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	## Limit number of concurrent connections per worer_processes' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	worker_connections 512;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	#multi_accept on;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	## Optionally "accept()" connections and pass to workers, good if workers gt 1' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	#accept_mutex on;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	## worker process will accept mutex after this delay in not assigned' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	#accept_mutex_delay 500ms;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '}' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo 'http {' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
#		## Buffer Overflows Mitigation
#		client_body_buffer_size 1K;
#		client_header_buffer_size 1K;
#		client_max_body_size 1K;
#		large_client_header_buffers 2 1K;
#		## Start Timeouts
#		client_body_timeout 10;
#		client_header_timeout 10;
#		keepalive_timeout 55s;
#		send_timeout 10;
#		spdy_keepalive_timeout 100s;
#		spdy_recv_timeout 4s;
#		## General Options
#		charset utf-8;
#		default_type application/octet-stream;
#		gzip off;
#		gzip_static on;
#		gzip_proxied any;
#		ignore_invalid_headers on;
#		include /etc/mime.tyes;
#		keepalive_requests 5;
#		keepalive_disable none;
#		max_ranges 1;
#		msie_padding off;
#		open_file_cache max=1000 inactive=1h;
#		open_file_cache_errors on;
#		open_file_cache_min_uses 1;
#		open_file_cache_valid 1h;
#		outpu_buffers 1 512;
#		read_ahead 512K;
#		recursive_error_pages on;
#		reset_timedout_connections on;
#		sendfile on;
#		## Turn off server signature
#		server_tokens off;
#		server_name_in_redirect off;
#		source_charset utf-8;
#		tcp_nodelay on;
#		tcp_nopush off;
#		## Request Limits
#		limit_req_zone $binary_remote_addr zone=gulag:1m rate=60r/m;
#		## Log format
#		log_format main '$remote_addr $host $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" $ssl_cipher $request_time';
#		## Global SSL options with "Perfect Forward Security"
#		## RSA ciphers
#		ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-RSA-AES256-SHA:ECDHE-RSA-RC4-SHA;
#		## ECDSA ssl ciphers
#		#ssl_ciphers ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA;
#		ssl_ecdh_curve secp384r1;
#		ssl_prefer_server_ciphers on;
#		ssl_protocols TLSv1.2 TLSv1.1 TLSv1;
#		#ssl_session_timeout 5m;
#		#SPDY timeout=180sec, keepalive=20sec; connection close=session expires
## Simultaneous Connection Limiters
#	limit_zone slimits $binary_remote_addr 5m;
#	limit_conn slimits 5;
## Robot Block Restrictions
#	if ($http_user_agent ~* msnbot|scrapbot) {
#		return 403;
#	}
	echo '	## Basic Settings' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	sendfile on;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	tcp_nopush on;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	tcp_nodelay on;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	keepalive_timeout 65;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	types_hash_max_size 2048;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	server_tokens off;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	#server_names_hash_bucket-size 64;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	server_name_in_redirect off;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo "	include ${_nginx_dir:-/etc}/nginx/mime.types;" | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	default_type application/octet-steam;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	## SSL settings' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	ssl_protocols TLSv1 TLSv1.1 TLSv1.2; ## Dropped TLSv3 ref POODLE' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	ssh_prefer_server_certs on;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	## Logging settings' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	acccess_log /var/log/nginx/access.log;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	error_log /var/log/nginx/error.log;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	## Gzip settings' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	gzip on;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	gzip_dissable "msie6";' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	#gzip_vary on;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	#gzip_proxied any;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	#gzip_comp_level 6;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	#gzip_buffers 16 8k;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	#gzip_http_version 1.1;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	#gzip_types text/plain text/css application/json application/javascript text/xml application//xml+rss text/javascript;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	## Virtual Hosts' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	include /etc/nginx/conf.d/*.conf;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '	include /etc/nginx/sites-enabled/*;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '}' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#mail {' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#	## See sample auth script' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#	#	https://wiki.nginx.org/ImapAuthenticationWithApachePhpScript' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#	#auth_http localhost/auth.php;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#	#pop3_capabilities "TOP" "USER";' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#	#imap_cababilities "IMAP4rev1" "UIDPLUS";' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#	server {' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#		listen localhost:110;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#		protocol pop3;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#		proxy on;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#	}' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#	server {' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#		listen localhost:143;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#		protocol imap;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#		proxy on;' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#	}' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo '#}' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf

	
	echo '' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	echo "" | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
	
}
#	echo '' | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
#	echo "" | sudo tee -a ${_nginx_dir}/nginx/nginx.conf
### Write_nginx_server_config_help write_nginx_server_config_help write_nginx_server_config.sh
#	File: ${_script_dir}/functions/nginx/config_nginx/write_nginx_server_config.sh
####
# under ~?/nginx/nginx.conf
## Set number of workers to number of CPU's
#	worker_processes 4;
## Set "nice" limmits to keep server from interfearing with other tasks
#	worker_priority 15;
## Maximum number if open files
#	worker_rlimit_nofile 1024;
## Events block
#	events {
#		## Limit number of concurrent connections per worer_processes
#		#worker_connections 512;
#		## Optionally "accept()" connections and pass to workers, good if workers gt 1
#		#accept_mutex on;
#		## worker process will accept mutex after this delay in not assigned
#		#accept_mutex_delay 500ms;
#	}
## http block
#	http {
#		## Buffer Overflows Mitigation
#		client_body_buffer_size 1K;
#		client_header_buffer_size 1K;
#		client_max_body_size 1K;
#		large_client_header_buffers 2 1K;
#		## Start Timeouts
#		client_body_timeout 10;
#		client_header_timeout 10;
#		keepalive_timeout 55s;
#		send_timeout 10;
#		spdy_keepalive_timeout 100s;
#		spdy_recv_timeout 4s;
#		## General Options
#		charset utf-8;
#		default_type application/octet-stream;
#		gzip off;
#		gzip_static on;
#		gzip_proxied any;
#		ignore_invalid_headers on;
#		include /etc/mime.tyes;
#		keepalive_requests 5;
#		keepalive_disable none;
#		max_ranges 1;
#		msie_padding off;
#		open_file_cache max=1000 inactive=1h;
#		open_file_cache_errors on;
#		open_file_cache_min_uses 1;
#		open_file_cache_valid 1h;
#		outpu_buffers 1 512;
#		read_ahead 512K;
#		recursive_error_pages on;
#		reset_timedout_connections on;
#		sendfile on;
#		## Turn off server signature
#		server_tokens off;
#		server_name_in_redirect off;
#		source_charset utf-8;
#		tcp_nodelay on;
#		tcp_nopush off;
#		## Request Limits
#		limit_req_zone $binary_remote_addr zone=gulag:1m rate=60r/m;
#		## Log format
#		log_format main '$remote_addr $host $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" $ssl_cipher $request_time';
#		## Global SSL options with "Perfect Forward Security"
#		## RSA ciphers
#		ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-RSA-AES256-SHA:ECDHE-RSA-RC4-SHA;
#		## ECDSA ssl ciphers
#		#ssl_ciphers ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA;
#		ssl_ecdh_curve secp384r1;
#		ssl_prefer_server_ciphers on;
#		ssl_protocols TLSv1.2 TLSv1.1 TLSv1;
#		#ssl_session_timeout 5m;
#		#SPDY timeout=180sec, keepalive=20sec; connection close=session expires
#		## HTTP redirect to HTTPs example
#		#server {
#		#	add_header Cache-Control "public";
#		#	access_log /var/log/nginx/access/log main buffer=32k;
#		#	error_log /var/log/nginx/error.log error;
#		#	expires max;
#		#	limit_req zone=gulag burst=200 nodelay;
#		#	listen 127.0.0.1:80;
#		#	root /var/empty;
#		#	return 301 https://example.onion$url;
#		#}
#		## HTTPs block
#		#server {
#		#	add_header Cache-Control "public";
#		#	add_header X-Content-Type-Option "nosniff";
#		#	add_header X-Frame-Options "DENY";
#		#	add_header Strict-Transport-Security "max-age=315360000; includeSubdomains";
#		#	access_log /var/log/nginx/access.log main;
#		#	error_log /var/log/nginx/error.log info;
#		#	expires max;
#		#	index index.html;
#		#	limit_req zone=gulag burst=200 nodelay;
#		#	listen 127.0.0.1:443 ssl spdy;
#		#	root /var/www/htdocs;
#		#	#server_name domain.onion www.domain.onion;
#		#	server_name "";
#		#	ssl on;
#		#	ssl_session_cache shared:SSL:1m;
#		#	ssl_certificate /ssl_keys/domain.onion_ssl.crt;
#		#	ssl_certificate_key /ssl_keys/domain.onion_ssl.key;
#		#	ssl_stapling on;
#		#	ssl_stapling_verify on;
#		## Add following if statements if neaded
#		## Redirect from www to non-www (strips args with '?' marks)
#		# if ($host != 'domain.onion') { return 301 https://domain.onion$url; }
## Available Methods Restrictions
#		if ($request_method !~ ^(GET|HEAD|POST)$ ) {
#			return 444;
#		}
## Domain Access Restrictions	(~.onion|www.~.onion) nead custom setting
#		if ($host !~ ^{domain.onion|www.domain.onion)$ ) {
#			return 444;
#		}
## User-Agent Restrictions
#		if ($http_user_agent ~* (Simple|BBBike|wget|Baiduspider|Jullo)) {
#			return 403;
#		}
## Referral Spam Restrictions
#		if ($http_referer ~* (babes|forsale|girl|jewelry|love|nudit|organic|poker|porn|sex|teen|video|webcam|zippo)) {
#			# return 404;
#			return 403
#		}
## Image Hotlinking Restrictions (option 1)
#		#location ~* (\.jpg|\.png|\.css)$ {
#		#	if ($http_referer !~ ^(http://domain.onion)) {
#		#		return 405;
#		#	}
#		#}
## Image Hotlinking Restrictions (option 2)
#		#location /images/ {
#		#	valid_referers none blocked www.domain.onion domain.onion;
#		#	if ($invalid_referer) {
#		#		return 403;
#		#	}
#		#}
## Image Hotlinking Restrictions (option 3)
#		#lid_referes blocked www.example.com example.com
#		#($invalid_referer) {
#		#	rewrite ^/images/uploads. *\.(gif|jpg|jpeg|png)$ http://www.examples.com/banned.jpg last
#		#}
## IP Address Restricted Directory /docs/ (option 1)
#		#location /docs/ {
#		#	## Block one workstation
#		#	deny	192.168.1.1;
#		#	## Allow local NAT
#		#	allow 192.168.1.0/24;
#		#	## Drop all other addresses
#		#	deny all;
#		#}
## IP Address Restricted Directory /secure/ (option 2)
#		#location ^~ /secure/ {
#		#	allow 127.0.0.1/32;
#		#	allow 10.10.10.0/24;
#		#	deny all;
#		#	auth_basic "RESTRICTED ACCESS";
#		#	auth_basic_user_file /var/www/htdocs/secure/access_list;
#		#}
## Serve empty 1x1 gif _OR_ and error 204 (No Content) for faveicon.ico
#		location = /faveicon.ico {
#			#empty_gif;
#			return 204;
#		}
## Default location with System Maintenance (Service Unavailable) check
#		location / { try_files system_maintenance.html $uri $uri/ =404; }
## All other errors get generic error page
#		error_page 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 495 496 497 500 501 502 503 504 505 506 507 /error_page.html;
#		location /error_page.html { internal; }
#		}
#	}
#	
## Simultaneous Connection Limiters
#	limit_zone slimits $binary_remote_addr 5m;
#	limit_conn slimits 5;
## Robot Block Restrictions
#	if ($http_user_agent ~* msnbot|scrapbot) {
#		return 403;
#	}
