Source_firetools_install(){
	Arg_checker "${@:---help='Source_firetools_install' --exit='# [] # Failed to be read arguments'}" -ep='Source_firetools_install'
	cd ${_temp_dir}/firetools_source
	if [ "$?" != "0" ]; then
		echo "## Notice [Source_firetools_install] function had to make [${_temp_dir}/firetools_source] directory"
		cd ${_temp_dir}/firetools_source
	fi
	git clone https://github.com/netblue30/firetools
	cd ${_temp_dir}/firetools_source/firetools
	./configure && make && make install
}
### Source_firetools_install_help source_firetools_install_help source_firetools_install.sh
#	File:	${_script_dir}/functions/firetools/installers/source_firetools_install.sh
####
