#!/bin/bash
## Installation de Python3 sur Debian

log(){
        m=$@
        echo "$(date) - $m"
}
set -e
VMAJ=3.9
V=3.9.1
B=$(pwd)/python-${V}
log Cleaning
rm -rf Python-${V}
rm -rf ${B}

log Dependencies
#Si jamais vous êtes sous CentOS ;)
#sudo yum -y install readline-devel ncurses-devel openssl-devel sqlite-devel gdbm-devel glibc-devel wget gcc make
sudo apt install -y wget build-essential python-dev
sudo apt install -y libdb-dev libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
sudo apt-get -qqy build-dep python3

sudo apt install python-setuptools python-pip python-smbus -y
sudo apt install libncursesw5-dev libgdbm-dev libc6-dev -y 
sudo apt install zlib1g-dev libsqlite3-dev tk-dev -y
sudo apt install libssl-dev openssl -y
sudo apt install libffi-dev -y

log Fetching
mkdir -p ~/python
cd ~/python
/usr/bin/wget https://www.python.org/ftp/python/$V/Python-$V.tgz
tar zxf Python-$V.tgz

log Compiling
cd Python-${V}
./configure --prefix=$B
make -j4
log Install
make altinstall

cd ../
rm -rf Python-${V}
rm -f Python-$V.tgz
echo -e "\n\nPython est disponible ici : $B"

#Création du virtualenv
PYVENV=~/venv-python$V
$B/bin/python${VMAJ} -m venv $PYVENV
echo "Le virtual env est dispo ici : $PYVENV"
