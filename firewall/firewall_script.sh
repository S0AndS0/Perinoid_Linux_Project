#!/bin/bash
_script_name="${0##*/}"
_script_dir="${0%/*}"
Source_functions(){
	source ${_script_dir}/vars/user_configs.sh
	source ${_script_dir}/vars/dynamic_configs.sh
	source ${_script_dir}/functions/write_iptables_chains.sh
	source ${_script_dir}/functions/multi_porpus/backup_iptables.sh
	source ${_script_dir}/functions/multi_porpus/icmp_v4_filter.sh
	source ${_script_dir}/functions/multi_porpus/icmp_v4_flood.sh
	source ${_script_dir}/functions/multi_porpus/icmp_v6_filter_flood.sh
	source ${_script_dir}/functions/multi_porpus/prompt_user_start.sh
	source ${_script_dir}/functions/multi_porpus/prompt_user_finish.sh
	source ${_script_dir}/functions/input_chains/input_bad_packets.sh
	source ${_script_dir}/functions/input_chains/input_udp_packets.sh
	source ${_script_dir}/functions/input_chains/input_v6_udp_packets.sh
	source ${_script_dir}/functions/input_chains/input_ban_filters.sh
	source ${_script_dir}/functions/input_chains/input_tcp_filters.sh
	source ${_script_dir}/functions/input_chains/input_v6_tcp_filters.sh
	source ${_script_dir}/functions/input_chains/input_v6_order.sh
	source ${_script_dir}/functions/input_chains/input_order.sh
	source ${_script_dir}/functions/input_chains/input_ip_filters.sh
	source ${_script_dir}/functions/output_chains/output_udp_packets.sh
	source ${_script_dir}/functions/output_chains/output_v6_udp_packets.sh
	source ${_script_dir}/functions/output_chains/output_tcp_filters.sh
	source ${_script_dir}/functions/output_chains/output_v6_tcp_filters.sh
	source ${_script_dir}/functions/output_chains/output_ban_filters.sh
	source ${_script_dir}/functions/output_chains/output_ip_filters.sh
	source ${_script_dir}/functions/output_chains/output_order.sh
	source ${_script_dir}/functions/output_chains/output_v6_order.sh
	source ${_script_dir}/functions/forward_chains/build_bridge.sh
	source ${_script_dir}/functions/forward_chains/forward_interface_or_ports.sh
}
Populate_iptables(){
	## Prompt user and output information about system read by this script
	Prompt_user_start || exit 1
	## Backup curent rule set such that script can restore if user does not like new rules
	Backup_iptables || exit 1
	## Build chian names bellow for population
	Write_iptables_chains || exit 1
	## Build chain : in_bad_ip
	Input_ip_filters || exit 1
	## Build chain : in_bad_packets
	Input_bad_packets || exit 1
	## Build chain : in_tcp
	Input_tcp_filters || exit 1
	## Build chain : in_woot_filter in_woot_ban in_shell_shock shell_shock_ban
	Input_ban_filters || exit 1
	## Build chain : icmp_filter
	Icmp_v4_filter || exit 1
	## Build chain : icmp_flood
	Icmp_v4_flood || exit 1
	## Build chain : in_udp
	Input_udp_packets || exit 1
	## Build chain : out_bad_ip
	Output_ip_filters || exit 1
	## Build chain : out_udp
	Output_udp_packets || exit 1
	## Build chain : out_port_scan
	Output_ban_filters || exit 1
	## Build chain : out_tcp
	Output_tcp_filters || exit 1
	## Build chain : icmp_filter_v6 icmp_flood_v6
	Icmp_v6_filter_flood || exit 1
	## Build chain : in_udp_v6
	Input_v6_udp_packets || exit 1
	## Build chain : in_tcp_v6
	Input_v6_tcp_filters || exit 1
	## Build chain : out_udp_v6
	Output_v6_udp_packets || exit 1
	## Build chain : out_tcp_v6
	Output_v6_tcp_filters || exit 1
	## Organize packet flow via chains that jump to above chains
	## Build chain : order_input
	Input_order || exit 1
	## Build chain : order_output
	Output_order || exit 1
	## Build chain : order_input_v6
	Input_v6_order || exit 1
	## Build chain : order_output_v6
	Output_v6_order || exit 1
	## Check if bridge interface is to be built
	Build_bridge || exit 1
	## Check for any port forwarding to bridge interface and or secondery IP address
	Forward_interface_or_ports || exit 1
	## Prompt user for keeping new rules and activating final jumps or restoring from backups
	Prompt_user_finish.sh
}
Source_functions || exit 1
Populate_iptables
