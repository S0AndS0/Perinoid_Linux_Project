Source_squid_install(){
	Arg_checker "${@:---help='Source_squid_install' --exit='# [Source_squid_install] # Failed to be read arguments'}" -ep='Source_squid_install'
	_config_squid_options="--prefix=${_squid_dir:-/etc}/squid"
	_squid_url="http://www.squid-cache.org/Versions/v3/3.5/squid-3.5.12-20151222-r13967.tar.gz"
	_squid_file_name="squid-3.5.12-20151222-r13967"
	cd ${_temp_dir}/squid_source
	if [ "$?" != "0" ]; then
		mkdir -p ${_temp_dir}/squid
		cd ${_temp_dir}/squid_source
		if [ "$?" != "0" ]; then
			exit 1
		fi
	fi
	wget -v "${_squid_url}"
	tar xzf ${_squid_file_name}.tar.gz
	cd ${_squid_file_name}
	if [ "$?" != "0" ]; then
		exit 1
	fi
	./configure ${_config_squid_options} &&\
	 make &&\
	 make install
}
### Source_squid_install_help source_squid_install_help source_squid_install.sh
#	File:	${_script_dir}/functions/squid/installers/source_squid_install.sh
####
