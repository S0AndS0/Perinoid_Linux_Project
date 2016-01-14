#!/bin/bash
export PATH=$PATH:/sbin
echo $PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

## Fix some enviroment stuff
dpkg-divert --add --local --divert /usr/sbin/invoke-rc.d.chroot --rename /usr/sbin/invoke-rc.d
cp /bin/true /user/sbin/invoke-rc.d
echo -e "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d
chmod +x /usr/sbin/policy-rc.d

locale-gen en_US.UTF-8
dpkg-reconfigure locales
tzconfig

passwd
apt-get update
apt-get upgrade
apt-get -y install gnupg locales dialog
apt-get -y install openssh-server ntpdate
apt-get -y install git-core binutils ca-certificates initramfs-tools u-boot-tools
apt-get -y install abootimg cgpt fake-hwclock ntpdate vboot-utils vboot-kernel-utils u-boot-tools
apt-get -y install initramfs-tools sudo parted e2fsprogs usbutils
apt-get -y install fonts-croscore fonts-crosextra-caladea fonts-crosextra-carlito gnome-theme-kali kali-desktop-xfce gtk3-engines-xfce lightdm network-manager network-manager-gnome xfce4 xserver-xorg-video-fbdev
apt-get -y install passing-the-hash winexe aircrack-ng hydra john sqlmap wireshark libnfc-bin mfoc nmap ethtool usbutils
apt-get -y install openssh-server apache2
apt-get -y install iceweasel xfce4-terminal wpasupplicant
apt-get --yes --force-yes dist-upgrade

apt-get clean
apt-get --yes --force-yes autoremove

#update-initramfs -u -k all
update-rc.d ssh enable

Kali_spicific(){
## Read full guide : https://www.offensive-security.com/kali-linux/raspberry-pi-luks-disk-encryption/
## Kali spicffic
#apt-get -y install kali-menu kali-defaults kali-root-login
#apt-get -y install busybox cryptsetup dropbear
#mkinitramfs -o /boot/initramfs.gz $(ls -l /lib/modules/ |awk -F" " '{print $9}')
## Modify /boot/cmdline.txt file to match
#root=/dev/mapper/crypt_sdcard cryptdevice=/dev/mmcblk0p2:crypt_sdcard rootfstype=ext4
#echo initramfs initramfs.gz 0x00f00000 & /boot/config.txt
## Modify /etc/initramfs-tools/root/.ssh/authorized_keys to have the following preffice the keys
#command="/scripts/local-top/cryptroot && kill -9 `ps | grep -m 1 'cryptroot' | cut -d ' ' -f 3`"
## Modify /etc/fstab to resemble the following
#proc /proc defaults 0 0
#/dev/mmcblk0p1 /boot vfat defaults 0 2
#/dev/mapper/crypt_sdcard / ext4 defaults,noatime 0 1
## then enable encrytpion with
#echo crypt_sdcard /dev/mmcblk0p2 none luks > /etc/crypttab
## Add wait so USB doesn't race with boot
## Modify /usr/share/initramfs-tools/scripts/init-premount/dropbear
## Append line above "configure_networking &"
#sleep 5
## save and reload configrations
#mkinitramfs -o /boot/initramfs.gz $(ls -l /lib/modules/ |awk -F" " '{print $9}')
}
exit $?
