#!/bin/bash
## Installation de Python3 sur Debian

log(){
        m=$@
        echo "$(date) - $m"
}
set -e
V=3.7.0
B=$(pwd)/python-${V}
log Cleaning
rm -rf Python-${V}
rm -rf ${B}

log Dependencies
#Si jamais vous êtes sous CentOS ;)
#sudo yum -y install readline-devel ncurses-devel openssl-devel sqlite-devel gdbm-devel glibc-devel wget gcc make
sudo apt install -y wget build-essential checkinstall python-dev
sudo apt install -y libdb-dev libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
sudo apt-get -qqy build-dep python3

sudo apt install python-setuptools python-pip python-smbus -y
sudo apt install libncursesw5-dev libgdbm-dev libc6-dev -y 
sudo apt install zlib1g-dev libsqlite3-dev tk-dev -y
sudo apt install libssl-dev openssl -y
sudo apt install libffi-dev -y


log Fetching
/usr/bin/wget https://www.python.org/ftp/python/$V/Python-$V.tgz
tar zxvf Python-$V.tgz

log Compiling
cd Python-${V}
./configure --prefix=$B
make -j6
log Install
make altinstall

cd ../
rm -rf Python-${V}
echo "Python est disponible ici : $B"

#Création du virtualenv
PYVENV=~/py$V
$B/bin/python3.7 -m venv $PYVENV
echo "Le virtual env est dispo ici : $PYVENV"
