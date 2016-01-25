Write_havp_conf(){
	_path="${1:-$_havp_path}"
	if [ -f $_path/havp.config ]; then
		echo "## Detected old $_path/havp.config file, backing it up before writing new one"
		sudo mv ${_path}/havp.config ${_path}/havp.orig
	fi
	echo '' | sudo tee -a $_path/havp.config
	echo '' | sudo tee -a $_path/havp.config
	echo '' | sudo tee -a $_path/havp.config
	echo '' | sudo tee -a $_path/havp.config
	echo '' | sudo tee -a $_path/havp.config
}
