#!/usr/bin/env bash

echo "-> Generating locale..." | tee -a /var/log/provision.log
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8 > /var/log/provision.log 2>&1
dpkg-reconfigure locales > /var/log/provision.log 2>&1

echo "-> Adding multiverse repository..." | tee -a /var/log/provision.log
echo "deb http://archive.ubuntu.com/ubuntu precise universe main multiverse restricted" > /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu/ precise-security universe main multiverse restricted" >> /etc/apt/sources.list

echo "-> Updating packages informations..."
apt-get update 2>&1 >> /var/log/provision.log

echo "-> Upgrading system..." | tee -a /var/log/provision.log
apt-get -y upgrade 2>&1 >> /var/log/provision.log

echo "-> Installing Apache2..." | tee -a /var/log/provision.log
apt-get -y install apache2 2>&1 >> /var/log/provision.log
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

echo "-> Installing PHP5.3..." | tee -a /var/log/provision.log
apt-get -y install libapache2-mod-php5 2>&1 >> /var/log/provision.log
if [ ! -f /var/www/index.php ]; then
  echo '<?php phpinfo(); ?>' > /var/www/index.php
fi

echo "-> Installing PHP Extensions..." | tee -a /var/log/provision.log
apt-get -y install php5-mysql php5-memcached php5-geoip php5-gd php5-mcrypt 2>&1 >> /var/log/provision.log

# echo "-> Installing MySQL..." | tee -a /var/log/provision.log
# echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
# echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
# apt-get -y install mysql-server > /var/log/provision.log 2>&1

echo "-> Tidying up..." | tee -a /var/log/provision.log
chmod -R 600 /etc/update-motd.d/*
apt-get -y remove cloud-init 2>&1 >> /var/log/provision.log

echo "-> Provision done, machine ready." | tee -a /var/log/provision.log
ifconfig eth1 | grep "inet " | cut -d ':' -f2 | awk '{print $1}'