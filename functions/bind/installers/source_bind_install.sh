Source_bind_install(){
	Arg_checker "${@:---help='Source_bind_install' --exit='# [Source_bind_install] # Failed to be read arguments'}" -ep='Source_bind_install'
	_bind9_url="ftp://ftp.isc.org/isc/bind9/9.10.3/BIND9.10.3.x86.zip"
	_bind9_source_namee="BIND9.9.10.3.x86"
	echo "## Warning [Source_bind_install] is untested, but as [${USER}] had to request [${_script_name}]"
	echo "#	to preform this function we will continue..."
	cd ${_temp_dir}/bind9_source
	if [ "$?" != "0" ]; then
		echo "## Notice [Source_bind_install] function had to create [${_temp_dir}/bind9_source] directory"
		mkdir -p ${_temp_dir}/bind9_source
		cd ${_temp_dir}/bind9_source
	fi
	wget -v ${_bind9_url}
	_bind9_tar=$(ls ${_temp_dir}/bind9_source)
	if [ -f ${_temp_dir}/bind9_source/${_bind9_source_name}.tar ]; then
		echo "#	[Source_bind_install] un-taring [${_bind9_source_name}.tar] file"
		tar xzvf ${_bind9_source_name}.tar
	elif [ -f ${_temp_dir}/bind9_source/${_bind9_source_name}.zip ]; then
		echo "#	[Source_bind_install] uuziping [${_bind9_source_name}.zip] file"
		unzip ${_bind9_source_name}.zip
	else
		Arg_checker --help='Source_bind_install' --exit="# [Source_bind_install] # Failed to detect [${_bind9_tar}] file under [${_temp_dir}/bind9_source]]"
		exit 1
	fi
	if [ -d ${_temp_dir}/bind9_source/${_bind9_source_name} ]; then
		cd ${_temp_dir}/bind9_source/${_bind9_source_name}
		./configure --with-openssl --enable-threads --with-libxmi2
		#make && make install
	else
		Arg_checker --help='Source_bind_install' --exit="# [Source_bind_install] # Failed to detect [${_temp_dir}/bind9_source/${_bind9_source_name}]] as a directory"
		exit 1
	fi
}
### Source_bind_install_help source_bind_install_help source_bind_install.sh
#	File:	${_script_dir}/functions/bind/installers/source_bind_install.sh
#	Argument	Variable		Default
#	[-t=...]	_temp_dir		/tmp
#	Note:	Depends on openssl and libxmi2 to be installed if configuring with defaults within this
#		function. Addtional depends maybe libssl-dev and libxmi2-dev packages
#		To find more mirrors for Bind9 source code try the following link
#		http://www.bind9.net/download
#		There you may find entries for spicific builds such as for the Raspberry Pi
#		ftp://ftp.isc.org/isc/bind9/9.10.3-P2/
#		or for 32bit CPU's (default link)
#		ftp://ftp.isc.org/isc/bind9/9.10.3/BIND9.10.3.x86.zip
#		Both [~.zip] and [~.tar] file formats are acceptable without overly comples modification
#		to this function; just two internall variables.
####
