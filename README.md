# Perinoid_Linux_Project
Where a Linux sys-admin's perinoid scripts are collected.

Project goals : to build sandcastles (metaphorically speaking) against tides that atempt to wash away privacy.
Thanks should be given to those that aided in this script pack's development, links to those documents that
where interagle in educating the authors of this script can be found within the [info] directory. 

See the [Read_Me.txt](https://github.com/S0AndS0/Perinoid_Linux_Project/blob/master/Read_Me.txt) file and project [wiki](https://github.com/S0AndS0/Perinoid_Linux_Project/wiki) for command line and script editing instructions.

# Not all features compleat!

# What does this script do?

Simply put, this a installation and configuration script bundle that is inspired from Whonix and other 
virtualization techniques for security and compartmentalization. This script accepts arguments in the 
form of [-arg='...'] or [--argument='...'] and if understood preforms the commanded action. If a command 
is not understood errors and helpfull documentation will display to aid users in completing the installation 
processes next time around. Pipes maybe used such as [-arg="$(comand)"] by sourounding the piped command 
with dubble quotes. Additionally entire variable files maybe loaded via [-vf=/path/to/vars] or 
[--var-file=/path/to/vars] to avoid having to learn this script's syntax for other arguments. Tor, firejail, 
firetools, nginx, privoxy, polipo, squid, bind9 are all currently available to install or re-configure 
through the use of [-A=application] or [-A=app1,app2] option and selecting installation method maybe 
chosen via [-I=source] or [-I=apt-get] or [-I=safe] or [-I=experiment] options.

# What does this script not do?

This script does not check host system for vurnablilaties or malware, nor does it make any geronty of 
increased security or privacy. In fact depending on arguments passed you make make your location easier 
to obtain, ie running an exit or bridge Tor node publishes your external IP address to others that nead 
to connect. This is because "privacy" and "anyonimity" are goals with many ends. Some users of these 
networks are more concerned with helping others acheive privacy so will run a bridge, exit, or relay 
depending upon preferences and legal ramifications others are more concerned with personal privacy or 
anonymity of friends so will instead opt for client or private bridge setup.

No licences just yet, and no warranties or geronties of any kind.

# Use at your own risk

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

```bash
bash ~/Downloads/GitSources/Perinoid_Linux_Project/Sancastle.sh --var-file='client_tor_install_vars.sh'
```

