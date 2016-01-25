#!/bin/bash
KVM_quick_install_check(){
	## Reports 0 if niether exsist 1 or more if both exsist
	_kernel_vert_compatibility=$(egrep -c '(vmc|svc)' /proc/cpuinfo)
	## Reports 0 if not 64 bit CPU or 1 if CPU is 64bit
	_cpu_64bit_check=$(egrep -c ' lm ' /proc/cpuinfo)
	## Reports [x86_64] if kernel is 64bit (synonymous with amd64) or i386, i486, i586, i686 if 32bit
	#	or reports [armv71] etc if on ARM CPUs
	_kernel_64bit_check=$(uname -m)
	if [ "${_kernel_vert_compatibility}" = "0" ]; then
		echo "## Error : KVM_quick_install_check function detected that this system does Not"
		echo "#	support kernel virtualization."
	elif [ "${_kernel_vert_compatibility}" -gt "0" ]; then
		echo "## Notice : KVM_quick_install_check function reports that this system Does"
		echo "#	support kernel virtualization. Installing dependacies now..."
		Install_Apt "qemu-kvm,libvirt-bin,ubuntu-vm-builder,bridge-utils"
		echo "#	Adding [$(id -un)] user to libvirtd group"
		sudo adduser $(id -un) libvertd
	fi
	echo "## Notice : KVM_quick_install_check function is requesting permissions to install"
	echo "#	the optional package [virt-manager] via apt-get, this maybe used by nearly any system"
	echo "#	within your local network to manage an exsisting virtual machien service remotely"
	echo -n "## Would you like to install [virt-manager] now ${USER}@$(hostname):~? "
	read _install_virtmanager_YN
	case $_install_virtmanager_YN in
		Y|y|Yes|yes)
			Install_Apt "virt-manager"
		;;
		*)
			echo "## Notice : KVM_quick_install_check function did Not read [Y/yes] in [${_install_virtmanager_YN}]"
			echo "#	now letting this function die quietly..."
		;;
	esac

}
#KVM_quick_install_check
