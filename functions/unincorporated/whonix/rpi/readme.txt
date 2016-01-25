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
