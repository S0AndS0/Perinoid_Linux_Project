Source_firetools_functions(){
	_dir="${1:-$_script_dir}/functions"
	source "${_dir}/firetools/order_firetools_install.sh"
	source "${_dir}/firetools/installers/aptget_firetools_install.sh"
	source "${_dir}/firetools/installers/source_firetools_install.sh"
#	source "${_dir}/firetools"
}
### Source_firetools_functions_help source_firetools_functions_help source_firetools_functions.sh
#	File:	${_script_dir}/functions/firetools/source_firetools_functions.sh
####
