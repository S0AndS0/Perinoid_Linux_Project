## cyberciti.biz ngix hardening #14
#	http://www.cyberciti.biz/tips/linux-unix-bsd-nginx-webserver-security.html
## Create user and passwd
#	mkdir /usr/local/nginx/conf/.htpasswd/
#	htpasswd -c /usr/local/nginx/conf/.htpasswd vivek
## Add user to exsisting
#	
## Nginx conf to appeend
#	location ~ /(personal-images/.*|delta/.*) {
#		auth_basic "Restricted";
#		auth_basic_user_file /usr/local/nginx/conf/.htpasswd/passwd;
#	}
