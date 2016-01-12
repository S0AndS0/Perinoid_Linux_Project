## Nginx server hardening SSL #15
#	http://www.cyberciti.biz/tips/linux-unix-bsd-nginx-webserver-security.html
## Make certs
#	cd /usr/local/nginx/conf
#	openssl genrsa -des3 -out server.key 1024;
#	openssl req -new -key server.key -out server.csr
#	cp server.key server.key.org
#	openssl rsa -in server.key.org -out server.key
#	openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
## Nginx server configuration
#	server {
#		server_name domain.onion;
#		listen 443;
#		ssl on;
#		ssl_certificate /usr/local/nginx/conf/server.crt;
#		ssl_certificate_key /usr/local/nginx/conf/server.key;
#		access_log /usr/local/nginx/logs/ssl_access.log;
#		error_log /usr/local/nginx/logs/ssl_error.log;
#	}
