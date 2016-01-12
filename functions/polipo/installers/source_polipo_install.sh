Source_polipo_install(){
	Arg_checker "${@:---help='Source_polipo_install' --exit='# [Source_polipo_install] # Failed to be read arguments'}" -ep='Source_polipo_install'
	_polipo_source_url="https://github.com/jech/polipo/archive/master.zip"
	_minifi_make_polipo='CDEBUGFLAGS="-Os -Wall" EXTRA_DEFINES="-DNDEBUG -DNO_IPv6 -DNO_STANDARD_RESOLVER -DNO_REDIRECTOR -DNO_FORBIDDEN" all'
	cd ${_temp_dir}/polipo_source
	if [ "$?" != "0" ]; then
		echo "## Notice [Source_polipo_install] function making temp directory [${_temp_dir}/polipo_source] to download source files to."
		mkdir -p ${_temp_dir}/polipo_source
		cd ${_temp_dir}/polipo_source
		if [ "$?" != "0" ]; then
			echo "## Error [Source_polipo_install] function could not change directoried to [${_temp_dir}/polipo_source]"
			echo '#	Exiting now...' && exit 1
		fi
	fi
	wget -v ${_polipo_source_url}
	mv master.zip polipo.zip
	unzip polipo.zip
	cd ${_temp_dir}/polipo_source/polipo
	
	make ${_minifi_make_polipo}
	# ... decompress
	# ... change dirs
	# ... autogent, autoconfigure, configure, make, make install
}
### Source_polipo_install_help source_polipo_install_help source_polipo_install.sh
#	File:	${_script_dir}/functions/polipo/installers/source_polipo_install.sh
#	Incompleat but nearly ready for testing, this function should only fire if
#	${_script_name}] detects both [-I='source'] and [-A='polipo'] arguments
####
