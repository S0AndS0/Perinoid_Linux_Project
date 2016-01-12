Source_privoxy_install(){
	Atg_checker "${@:---help='Source_privoxy_install' --exit='# [Source_privoxy_install] # Failed to be read arguments'}" -ep='Source_privoxy_install'
	_privoxy_source_dir="${_temp_dir}/privoxy_source"
	_privoxy_link='http://sourceforge.net/projects/ijbswa/files/Sources/3.0.23%20%28stable%29/privoxy-3.0.23-stable-src.tar.gz/download'
	echo "## Warning [Source_privoxy_install] function untested"
	cd ${_privoxy_source_dir}
	if [ "$?" != "0" ]; then
		echo "## Notice [Source_privoxy_install] making directory [${_privoxy_source_dir}] for downloading source files"
		mkdir -p ${_privoxy_source_dir}
		cd ${_privoxy_source_dir}
	fi
	wget -v ${_privoxy_link}
	_privoxy_tar=$(ls ${_privoxy_source_dir})
	if [ -f ${_privoxy_source_dir}/${_privoxy_tar} ]; then
		echo "#	[Source_privoxy_install] un-taring [${_privoxy_tar}] file"
		tar xzvf ${_privoxy_tar}
	else
		Arg_checker --help='Source_privoxy_install' --exit="# [Source_privoxy_install] # Failed to detect [${_privoxy_tar}] file under [${_privoxy_source_dir}]"
		exit 1
	fi
	if [ -d ${_privoxy_source_dir}/privoxy ]; then
		cd ${_privoxy_source_dir}/privoxy
		autoheader &&\
		 autoconf &&\
		 ./configure --with-user=${_privoxy_user} --with-group=${_privoxy_user} --dissable-togle --disable-editor --disable-force &&\
		 make &&\
		 make -s install USER=${_privoxy_user} GROUP=${_privoxy_user}
	else
		Arg_checker --help='Source_privoxy_install' --exit="# [Source_privoxy_install] # Failed to detect [/privoxy] dir under [${_privoxy_source_dir}]"
		exit 1
	fi
}
### Source_privoxy_install_help source_privoxy_install_help source_privoxy_install.sh
#	File:	${_source_dir}/functions/privoxy/installers/source_privoxy_install.sh
#	This function may not be the best idea to use if conserned about MiTM attacks as the host used
#	to download from does not use SSL and this function does not check keys befor processing. Usefull
#	for those that nead source compiled features enabled or disabled. Uses the following arguments
#	passed to [${_script_name}]
#	Argument	Vaiable		Default
#	[-PD=...]	_privoxy_dir	/etc
#	[-PU=...]	_privoxy_user	privoxy
#	[-t=...]	_temp_dir	/tmp
####
