#!/bin/bash
## Installation de Python3 sur Debian
set -e

mkdir -p ~/python
cd ~/python

V=3.9.1
VMAJ=$(echo $V|sed 's/..$//')
B=~/python/python-${V}
rm -rf ${B}

#Si vous êtes sous CentOS: 
#sudo yum -y install readline-devel ncurses-devel openssl-devel sqlite-devel gdbm-devel glibc-devel wget gcc make
sudo apt install -y wget build-essential python-dev
sudo apt install -y libdb-dev libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
#sudo apt-get -qqy build-dep python3
sudo apt-get -qqy python3

sudo apt install python-setuptools python-pip python-smbus -y
sudo apt install libncursesw5-dev libgdbm-dev libc6-dev zlib1g-dev libsqlite3-dev tk-dev libssl-dev openssl libffi-dev -y

/usr/bin/wget https://www.python.org/ftp/python/$V/Python-$V.tgz
tar zxf Python-$V.tgz

cd Python-${V}
./configure --prefix=$B
make -j4
make altinstall

cd ../
rm -rf Python-${V}
rm -f Python-$V.tgz
echo -e "\n\nPython est disponible ici : $B"

#Création du virtualenv
PYVENV=~/venv-python$V
$B/bin/python${VMAJ} -m venv $PYVENV
echo "Le virtual env est disponible ici : $PYVENV"
