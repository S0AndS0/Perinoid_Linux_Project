Install_Apt(){
	_apt_list="${1:?Error no package names passed to Install_Apt function}"
#	_application_list="${1:?Error no package names passed to Install_Apt function}"
	_apt_target_release="$2"
	_auto_yn="${3:-NULL}"
	for _app in ${_apt_list//,/ }; do
		if [ -f $(which $_app) ];then
			echo "## Notice: Install_Apt detected $_app was already installed"
		else
			if [ "${#_app_list}" = "0" ]; then
				_app_list="$_app"
			elif [ "${#_app_list}" != "0" ]; then
				_app_list="${_app_list},${_app}"
			fi
		fi
	done
	echo "## Notice: Install_Apt detected the following applications should be installed"
	echo "#	${_app_list//,/ }"
	case $_auto_yn in
		Y)
			#sudo apt-get -y upgrade
			if [ "${#_apt_target_release}" != "0" ]; then
				sudo apt-get -t ${_apt_target_release} -y install ${_app_list//,/ }
			else
				sudo apt-get -y install ${_app_list//,/ }
			fi
		;;
		yes)
			#sudo apt-get upgrade
			if [ "${#_apt_target_release}" != "0" ]; then
				sudo apt-get -t ${_apt_target_release} -y install ${_app_list//,/ }
			else
				sudo apt-get -y install ${_app_list//,/ }
			fi
		;;
		*)
			#sudo apt-get upgrade
			sudo apt-get install ${_app_list//,/ }
		;;
	esac
}
### Install_Apt_help install_apt_help install_apt.sh
#	File:	${_script_dir}/functions/shared/install_apt.sh
#	Positional Argument examples
## Install_Apt $1 $2
#	Positional Argument explanaitions
#	First argument can be a cama seperated list of packages to check for installation
#	Second argumet can be Y|yes| |*| which if "Y" will input -y into install and update
#	commands or if "yes" will only add -y to install process, if anything else propmpts
#	will be presented during script run-time
####
