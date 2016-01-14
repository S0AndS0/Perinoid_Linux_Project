Enable_HYP_mode_rpi2(){
	_New_bootblk_bin="$1"
	_Path_to_kernel="${2:-/boot}"
	_Name_of_kernel="${3:-kernel7_original.img"
	case ${_New_bootblk_bin} in
		bootblk.bin)
			echo "#	catatinating ${_New_bootblk_bin} and ${_Path_to_kernel}/${_Name_of_kernel}"
			echo "#	into new /boot/kernel7.img"
			cat ${_New_bootblk_bin} ${_Path_to_kernel}/${_Name_of_kernel} > /boot/kernel7.img
#			chmod --reference=/boot/kernel7.img.bak /boot/kernel7.img
			echo "#	Enabling 'kernel_old=1' within /boot/config.txt"
			echo 'kernel_old=1' | tee -a /boot/config.txt
		;;
		kernel7.img)
			echo "#	copying new ${_New_boot_bin} to /boot/kernel7.img"
			cp ${_New_boot_bin} /boot/kernel7.img
#			chmod --reference=/boot/kernel7.img.bak /boot/kernel7.img
			echo "#	Enabling 'kernel_old=1' within /boot/config.txt"
			echo 'kernel_old=1' | tee -a /boot/config.txt
		;;
		*)
			echo "## Error : Enable_HYP_mode_rpi2 function did not read [${_New_bootblk_bin}]"
			echo "#	as either image or bin file, critical changes have been preformed"
			echo "#	however you may have lingering installations and backups not serving any perpious"
			echo "#	try re-running after debugging why this file was not found on your system."
			ls -hal /boot/kernel7.img*
			ls -hal /boot/config.txt*
		;;
	esac
}
