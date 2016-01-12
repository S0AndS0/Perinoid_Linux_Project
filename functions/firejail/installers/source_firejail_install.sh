Source_firejail_install(){
	_download_dir="${_temp_dir}/firejail_source"
	cd $_download_dir
	if [ "$?" != "0" ]; then
		echo "## Notice [Source_firejail_install] had to create [${_download_dir}] directory"
		mkdir -p ${_downlaod_dir}
		cd $_download_dir
	fi
	git clone https://github.com/netblue30/firejail
	cd ${_download_dir}/firejail
	./configure
	make
	sudo make install-strip
}
### Source_firejail_install_help source_firejail_install_help source_firejail_install.sh
##	File:	${_script_dir}/functions/firejail/installers/source_firejail_install.sh
##	Argument	Variable		Default
#	[-t=...]	_temp_dir		/tmp
##	Notes: 
##	Depedancies:	gcc make
##	Configuration options
#	prefix: /usr/local
#	sysconfdir: ${prefix}/etc
#	seccomp: -DHAVE_CHROOT
#	<linux.seccomp.h>
#	chroot: -DHAVE_CHROOT
#	bind: -DHAVE_BIND
#	
####
