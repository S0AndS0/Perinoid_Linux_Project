# Perinoid_Linux_Project
Where a Linux sys-admin's perinoid scripts are collected.

See the Read_Me.txt file for command line and script editing instructions.
See info directory for files that contain links to sources used for building this script pack.

# Not all features compleat!

No licences just yet, and no warienties or geronties of any kind.

# Use at your own risk

# S0AndS0's To-Do list

- add options beyond [-C=...] for setting socks port in Tor client torrc file and Privoxy

- compleat nginx installation and configuration for hidden service, exit and public bridge node options

- incorperate firewall directory's scipts into `functions/iptables` directory and add parser

- add fail2ban filters and actions for hidden services and exit nodes

- add Whonix installer to main script

- add `KVM` installer to main script

- add `VMWare` installer to main script

- add apparmor and selinux configurations/modifications

- add ModSecurity installation and configurations for exsisting nginx source install options

- add sujestions from requests

# Quick start guide for `Sandcastle.sh`
Make a download directory if not already there and clone source
    mkdir -p ~/Downloads/GitSources
    cd ~/Downloads/GitSources
    git clone https://github.com/S0AndS0/Perinoid_Linux_Project
    chmod +x Perinoid_Linux_Project/Sancastle.sh
    cd ~
Print help documentation
    # General help
    bash ~/Downloads/GitSources/Perinoid_Linux_Project/Sancastle.sh -h
    # Spiciffic help for "Check_host_enviroment" function
    bash ~/Downloads/GitSources/Perinoid_Linux_Project/Sancastle.sh --help=Check_host_enviroment
    # Spiciffic help for "" & "" functions
    bash ~/Downloads/GitSources/Perinoid_Linux_Project/Sancastle.sh --help=Check_host_enviroment,Arg_checker


## Install Tor as client with privoxy squid and bind9 local DNS server
# bash Perinoid --var-file='client_tor_install_vars.sh'

