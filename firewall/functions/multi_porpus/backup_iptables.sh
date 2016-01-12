Backup_iptables(){
	echo '## Backing up current rules'
	if ! [ -d ${_script_dir}/backups ]; then
		mkdir -p ${_script_dir}/backups || exit 1
	fi
	if ! [ -f ${_script_dir}/backups/${_name_backup}.v4 ]; then
		iptables-save > ${_script_dir}/backups/${_name_backup}.v4 || exit 1
	else
		_name_backup="${_name_backup}_$(date +%F)"
		iptables-save > ${_script_dir}/backups/${_name_backup}.v4 || exit 1
	fi
	if ! [ -f ${_script_dir}/backups/${_name_backup}.v6 ]; then
		ip6tables-save > ${_script_dir}/backups/${_name_backup}.v6 || exit 1
	else
		_name_backup="${_name_backup}_$(date +%F)"
		ip6tables-save > ${_script_dir}/backups/${_name_backup}.v6 || exit 1
	fi
}
