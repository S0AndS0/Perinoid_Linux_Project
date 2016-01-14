Backup_RPi2_boot_files(){
	echo "#	Moving old /boot/kernel7.img to /boot/kernel7_original.img"
	mv /boot/kernel7.img /boot/kernel7_original.img
	echo "# Backing up /boot/config.txt to /boot/config.txt.bak"
	cp --interactive --preserve=all /boot/config.txt /boot/config_original.txt
}
Restore_RPi2_boot_files(){
	echo "## Something most have gone wrong..."
	echo "#	Moving modified /boot/kernel7.img to /boot/kernel7_mod.img.bak"
	mv /boot/kernel7.img /boot/kernel7_mod.img.bak
	echo "#	Backing up modifide /boot/config.txt to /boot/config_mod.txt.bak"
	cp --interactive --preserve=all /boot/config.txt /boot/config_mod.txt.bak
	echo "#	Restoring old kernel7.img and config.txt"
	mv /boot/kernel7_original.img /boot/kernel7.img
	cp --preserve=all /boot/config_original.txt /boot/config.txt

}
