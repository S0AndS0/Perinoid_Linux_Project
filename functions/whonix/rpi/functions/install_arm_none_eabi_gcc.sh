Install_arm_none_eabi_gcc(){
	_download_dir="$1"
	_source_install_dir="$2"
	cd ${_download_dir}
	if [ "$?" != "0" ]; then
		mkdir -p ${_download_dir}
		cd ${_download_dir}
	fi
	wget https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q3-update/+download/gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2
	cd ${_source_install_dir}
	if [ "$?" != "0" ]; then
		mkdir -p ${_source_install_dir}
		cd ${_source_install_dir}
	fi
	tar xjf ${_download_dir}/gcc-arm-none-eabi-4_9*.tar.bz2
}
