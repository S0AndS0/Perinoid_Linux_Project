Source_nginx_install(){
	Arg_checker "${@:---help='Source_nginx_install' --exit='# [Source_nginx_install] # Failed to be read arguments'" -ep='Source_nginx_install'
	
	echo "## Notice [Source_nginx_install] now beguining make process"
	read _user_source_nginx
#wget http://nginx.org/download/nginx-1.9.9.zip

	make clean;\
	 ./configure --with-http_ssl_module --with-http_spdy_module --with-http_gzip_static_module --with-file-aio\
	 --without-http_autoindex_module --without-http_browser_module --without-http_fastcgi_module --eithout-http_geo_module\
	 --without-http_empty_gif_module --without-http_map_module --without-http_proxy_module\
	 --without-http_memcached_module --without-http_ssl_module --without-http_userid_module\
	 --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module\
	 --without-http_split_clients_modual --without-http_uwsgi_module --without-http_scgi_module\
	 --wthout-http_limit_conn_module --without-http_referer_module --without-http-cache\
	 --without-http_upstream_ip_hash_module &&\
	 make &&\
	 make install
}
### Source_nginx_install_help source_nginx_install_help source_nginx_install.sh
#	File:	${_script_dir}/functions/nginx/installers/source_nginx_install.sh
#
####
