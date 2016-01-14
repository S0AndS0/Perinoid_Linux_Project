#!/bin/bash

# Install dependancies
sudo aptitude install python-dev

# Make directories for software
mkdir -p ~/mpich2_interpreters

# Download and extract source
cd ~/mpich2_interpreters
wget https://mpi4py.googlecode.com/files/mpi4py-1.3.1.tar.gz
tar -zxf mpi4py-1.3.1
python setup.py build
python setup.py install

# Setup Python interpreter in bash
echo "export PYTHONPATH=/home/pi/mpich2_interpreters/mpi4py-1.3.1" | sudo tee -a ~/.bashrc

# Wrapup part 1b
echo "Install part 1b done. The following command should produce no errors"
echo "mpiexec -n 5 python demo/helloworld.py"
echo "Thanks again TinkerNut : https://www.tinkernut.com/2014/04/make-cluster-computer/"

