Build_HYP_complient_rpi2_bootblk_bin(){
	_download_dir="$1"
	_source_install_dir="$2"
	export PATH=$PATH:${_source_install_dir}/gcc-arm-none-eabi-4_9-2014q4/bin
	cd ${_download_dir}
	if [ "$?" != "0" ]; then
		mkdir -p ${_download_dir}
		cd ${_download_dir}
	fi
	git clone https://github.com/slp/rpi2-hyp-boot.git
	cd ${_download_dir}/rpi2-hyp-boot
	make
}
