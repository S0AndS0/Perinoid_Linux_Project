Source_tor_install(){
	Arg_checker "${@:---help='Source_tor_install' --exit='# [Source_tor_install] # Failed to be read arguments'}" -ep='Source_tor_install'
	_tor_dir="${_tor_directory:-/etc}"
	_tor_source_url="https://github.com/torproject/tor/archive/master.zip"
#	_temp_dir="${1:-/tmp/tor_source_download}"
#	_tor_directory="${2:-/home/tor/chroot}"
#	_tor_user="${3:-debain-tor}"
	echo "## Warning [Source_tor_install] function is still untested. But as you had to tell [${_script_name}]"
	echo "#	to atempt it then we shall try for you [${USER}] to the best otf the authors abilaties..."
	cd ${_temp_dir}/tor_source
	if [ "$?" != "0" ]; then
		echo "## Notice : [Source_tor_install] function had to create [${_temp_dir}/tor_source] directory"
		mkdir -p ${_temp_dir}/tor_source
		cd $_temp_dir/tor_source
		if [ "$?" != "0" ]; then
			echo "## Error : [Source_tor_install] function unable to find [${_temp_dir}] directory"
			echo "#	exiting now..." && exit 1
		fi
	fi
	wget -v ${_tor_source_url}
	mv master.zip tor.zip
	unzip tor.zip
	cd ${_temp_dir}/tor_source/tor
	sh autogen.sh &&\
	 ./configure --prefix=/usr --sysconfdir=${_tor_dir:-/etc} --localstatedir=/var --with-tor-user=${_tor_user} &&\
	make
	if ! [ -d ${_tor_dir}/tor ]; then
		sudo mkdir -p ${_tor_dir}/tor
	fi
	sudo make install prefix=${_tor_dir}/tor exec_prefix=${_tor_dir}/tor
}
### Source_tor_install_help source_tor_install_help source_tor_install.sh
#	File:	${_script_dir}/functions/tor/installers/source_tor_install.sh
#	Reads arguments passed to [${_script_name}] and is only activated if [-I='source']
#	default is to atempt to install via [apt-get] commands but this function exsists
#	for those that can not wait for thier deb lists to update or are not on Debian
#	based Linux yet still meet the minimum requirements to run Tor related services.
#	Feel free to "fork" the repo that [${_script_name}] came from to offer murge requests
#	if edits should be made.
####
