# Perinoid_Linux_Project
Where a Linux sys-admin's perinoid scripts are collected.

Project goals : to build sandcastles (metaforicly speeking) against tides that atempt to wash away privacy.
Thanks should be given to those that aided in this script pack's development, links to those documents that
where interagle in educating the authors of this script can be found within the [info] directory. 

See the Read_Me.txt file for command line and script editing instructions.

# Not all features compleat!

# What does this script do?

Simplely put, this a installation and configuration script bundle that is inspired from Whonix and other 
virtualization tecniques for security and compartimintalization. This script accepts agruments in the 
form of [-arg='...'] or [--argument='...'] and if understood preforms the commanded action. If a command 
is not understood errors and helpfull documentation will display to aid users in compleating the installation 
processes next time around. Pipes maybe used such as [-arg="$(comand)"] by sourounding the piped command 
with dubble quotes. Additionally entire variable files maybe loaded via [-vf=/path/to/vars] or 
[--var-file=/path/to/vars] to avoid having to learn this scirpt's sytax for other arguements. Tor, firejail, 
firetools, nginx, privoxy, polipo, squid, bind9 are all currently available to install or re-configure 
through the use of [-A=application] or [-A=app1,app2] option and sellecting installation method maybe 
chosen via [-I=source] or [-I=apt-get] or [-I=safe] or [-I=experoment] options.

# What does this script not do?

This script does not check host system for vurnablilaties or malware, nore does it make any geronty of 
increesed security or privacy. In fact depending on arguments passed you make make your location easier 
to obtain, ie running an exit or bridge Tor node publishes your externall IP address to others that nead 
to connect. This is because "privacy" and "anyonimity" are goals with many ends. Some users of these 
networks are more conserned with helping others acheive privacy so will run a bridge, exit, or relay 
depending upon prefferances and leagal ramifacations others are more conserned with personal privacy or 
anonimity of freinds so will instead opt for client or private bridge setup.


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

```bash
mkdir -p ~/Downloads/GitSources
cd ~/Downloads/GitSources
git clone https://github.com/S0AndS0/Perinoid_Linux_Project
chmod +x Perinoid_Linux_Project/Sancastle.sh
cd ~
```

Print help documentation

```bash
# General help
bash ~/Downloads/GitSources/Perinoid_Linux_Project/Sancastle.sh -h
# Spiciffic help for "Check_host_enviroment" function
bash ~/Downloads/GitSources/Perinoid_Linux_Project/Sancastle.sh --help=Check_host_enviroment
# Spiciffic help for "Check_host_enviroment" & "Arg_checker" functions
bash ~/Downloads/GitSources/Perinoid_Linux_Project/Sancastle.sh --help=Check_host_enviroment,Arg_checker
```

Install Tor as client with privoxy squid and bind9 local DNS server

`bash ~/Downloads/GitSources/Perinoid_Linux_Project/Sancastle.sh --var-file='client_tor_install_vars.sh'`

