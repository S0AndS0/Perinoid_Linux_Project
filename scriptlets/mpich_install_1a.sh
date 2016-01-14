#!/bin/bash

# Make drirectories for varias software
mkdir -p ~/mpich2
mkdir -p ~/mpi-build
sudo mkdir -p /home/rpimpi/mpi-install

# Download dependancies
sudo apt-get install gfortran


# Download and extract source
cd ~/mpich2
wget http://www.mpich.org/static/downloads/3.1/mpich-3.1.tar.gz
tar -xfz mpich-3.1.tar.gz

# Make install from source and install
cd ~/mpi-build
sudo ~/mpich2/mpich-3.1/configure -prefix=/home/rpimpi/mpi-install
sudo make
sudo make install

# Add file path to bash
echo "PATH=$PATH:/home/rpimpi/mpi-install/bin" | sudo tee -a /.bashrc

# Wrap up part 1a
echo "After reboot you should be able to run the following command without errors"
echo "mpiexec -n 1 hostname"

echo "Thanks be to TinkerNut : https://www.tinkernut.com/2014/04/make-cluster-computer/"
echo "Part 1a done"
