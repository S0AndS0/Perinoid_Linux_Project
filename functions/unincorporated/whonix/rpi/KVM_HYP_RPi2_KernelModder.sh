#!/bin/bash
Warning_of_RPi2_Brinking(){
	if [ "${#@}" = "0" ]; then
		echo "## Warning : Enabling HYP mode on Raspberry Pi 2 is experomental,"
		echo "#	efforts have been made to limit risk via backing up old configurations"
		echo "#	but no geronties or warenties are claimed or infered by the authors."
		echo "#	Infact you may 'Brick' your RPi perminatly now or in the future."
		echo -n "## [Y/yes] or [N/no] Continue? "
		read _user_var_YN
	else
		_user_var_YN="$@"
	fi
	case "${_user_var_YN}" in
		Y|Yes|yes)
			Install_Apt "bc"
			Backup_RPi2_boot_files
			Prompt_HYP_install_type
		;;
		YES)
			echo "## Installing dependancies from apt-get"
			echo "#	bc"
			Install_Apt "bc"
			Backup_RPi2_boot_files
			Prompt_HYP_install_type "#"
		;;
		*)
			echo "# No or invalid input recieved, now allowing other processes..."
		;;
	esac
}
Prompt_HYP_install_type(){
	if [ "${#@}" = "0" ]; then
		echo "## Notice : if building from source ignore and press [Enter] when prompted"
		echo "#	or if using prebuilt image imput the directory"
		echo "#	that the new 'kernal7.img' was downloaded to"
		echo '# Download Link :'
		echo '#	https://drive.google.com/file/d/0B1QBSii9IJ1NSzhHVlpOak52MDA/view?pli=1'
		echo '#	md5sum Feb 25 2015 :'
		echo '#	356788d260e1a93376c5b8acbb63da13'
		echo -n "## Input file path or press [Enter] to install from source instead "
		read _Dpath
	else
		_Dpath="$@"
	fi
	case "$_Dpath" in
		/*)
			if [ -f "${_Dpath}/kernel7.img" ]; then
				_New_kernel="${_Dpath}/kernel7.img"
			elif [ -f "${_Dpath}" ]; then
				if [ "${_Dpath##*/}" = "kernel7.img" ]; then
					_New_kernel="${_Dpath}"
				else
					echo "## Error : Enable_mode_rpi2 did Not reconise [${_Dpath##*/}"
					echo "#	as being kernel7.img file. Quiting this script now."
					exit 1
				fi
			else
				echo "## Error : Enable_HYP_mode_rpi2 did Not reconise [${_Dpath}]"
				echo "#	to contain kernel7.img file. Quiting this script now."
				exit 1
			fi
			Enable_HYP_mode_rpi2 "${_New_kernel}"
		;;
		*)
			echo "## Installing arm-none-eabi-gcc and building bootblk.bin from source now."
			Install_arm_none_eabi_gcc "${_download_dir}" "${_source_install_dir}"
			echo '## Notice'
			echo ''
			echo ''
			echo "## Press [Enter] to continue."
			read
#			Download_rpi2_source
			Build_HYP_complient_rpi2_bootblk_bin "${_download_dir}" "${_source_install_dir}"
			if [ -f ${_download_dir}/bootblk.bin ]; then
				echo "#	Notice : Build_HYP_complient_rpi2_kernel function was sucsessful"
				echo "#	Now moving on to making new kernal.img with bootblk.bin included..."
#				Enable_HYP_mode_rpi2 "${_download_dir}/bootblk.bin"
			fi
		;;
	esac
}

Download_rpi2_source(){
	_download_dir="$1"
	
	cd ${_downlaod_dir}
	if [ "$?" != "0" ]; then
		mkdir -p ${_download_dir}
		cd ${_download_dir}
	fi
	
	git clone --depth=1 https://github.com/raspberrypi/linux
}
#						
#					
Check_last_boot_kernel(){
	_search_svc=$(grep -E "SVC" /var/log/kern.log | tail -n1)
	_search_hyp=$(grep -E "HYP" /var/log/kern.log | tail -n1)

	if "${#_search_scv}" != "0" ]; then
		echo "## Notice : Check_last_boot_kernel found your device does not have"
		echo "#	CPU vitrualization support enabled. Have you run the script"
		echo -n "#	for enabling HYP mode yet? "
		read _user_input_YN
		case "${_user_input_YN}" in
			n|N|no|No|NO)
#				bash ${_dir}/install_hyp_mode_rpi.sh
			;;
			*)
				echo "## Lagit error : please report this bug and include"
				echo "#	scrubed logs and discription to script authors."
				echo '# press [Ctrl^c] to quit or [Enter] to restore old'
				echo "#	kernel7.img and config.txt"
				read
				Restore_RPi2_boot_files
				exit 2
			;;
		esac
	elif "${#_search_svc}" = "0" ]; then
		echo "## Notice : Check_last_boot_kernel function did not detect 'SVC'"
		echo "#	within your kernel.log file, checking for 'HYP' mode next"
		if [ "${#_search_hyp}" != "0" ]; then
			echo "## Notice : found the following in kernel.log"
			echo "#	${_search_hyp}"
			echo "#	This is great news and we can now dedicate the last two"
			echo "#	CPUs of you Raspberry Pi to a new virtual machien"
			Enable_kvm_rpi
		fi
	fi
}
Enable_kvm_rpi(){

}
## Note : depends upon external function "Install_Apt"
###
## Step 1
#	Warning_of_RPi2_Brinking "<yes>|<no>|<YES>"
#	# Runs functions based off user responce, yes = run with prompts, YES = run
#	#  without prompts (risky), no/* = quit without running any other function
#	Prompt_HYP_install_type "</boot/kernel7.img>|</source/built/kernel7.img>|</boot>|<#>"
#	# If no arguments passed then prompt for file path to kernel7.img file, if file path
#	#  was passed as argument and kernel7.img exsists there then enable it, if file path
#	#  or argument does Not contain kenrel7.img then run Install_arm_none_eabi_gcc and
#	#  Download_rpi2_source and Build_HYP_complient_rpi2_bootblk_bin and Enable_HYP_mode_rpi2
#	#  functions to downlaod and build everything localy. Basicly if you have downloaded the
#	#  pre-compiled kernel this function shourtcuts the building phase.
#	Check_last_boot_kernel
#	# Checks if kernel.log file has SVC or HYP enabled on last boot, then
#	#  prompts user if hyp mode was not found to re-run or quit or if hyp
#	#  was detected run the next phase of installing a second OS dedicated
#	#  to the last cpu processor and own file system.
#source ${_dir}/whonix_recipes/rpi/functions/backup_restore_kernel_boot.sh
#	Backup_RPi2_boot_files
#	Restore_RPi2_boot_files
#	# Above functions take NO arguments and do what they say they do
#source ${_dir}/whonix_recipes/rpi/functions/install_arm_none_eabi_gcc.sh
#	Install_arm_none_eabi_gcc
#	# Downloads and installs from source the required gcc library for
#	#  building custom kernels and such for ARM CPUs
#source ${_dir}/whonix_recipes/rpi/functions/build_rpi2_bootblk_bin.sh
#	Build_HYP_complient_rpi2_bootblk_bin
#	# Download source code and build bootblk.bin file that can be murged
#	#  into the kernel7.img file to enable virtualization.
## Step 2
#source ${_dir}/TOR/whonix_recipes/rpi/functions/enable_hyp_mode.sh
#	Enable_HYP_mode_rpi2 "$_New_bootblk_bin" "$_Path_to_kernel" "$_Name_of_kernel"
#	Enable_HYP_mode_rpi2 "$<bootblk.bin>|<kernel7.img>" "/boot" "kernel7_original.img"
###
Source_RPi2_functions(){
	source ${_dir}/whonix_recipes/rpi/functions/backup_restore_kernel_boot.sh
	source ${_dir}/whonix_recipes/rpi/functions/install_arm_none_eabi_gcc.sh
	source ${_dir}/whonix_recipes/rpi/functions/build_rpi2_bootblk_bin.sh
	source ${_dir}/whonix_recipes/rpi/functions/enable_hyp_mode.sh
}
#Source_RPi2_functions
#Warning_of_RPi2_Brinking "$@"
