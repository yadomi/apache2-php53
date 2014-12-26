#!/usr/bin/env bash

# Create provision log file
if [ -f /tmp/foo.txt ]; then
    rm /var/log/provision.log
fi
touch /var/log/provision.log

echo "#1 Installing locale..." | tee -a /var/log/provision.log
apt-get -y install language-pack-fr 2>&1 > /var/log/provision.log
locale-gen fr_FR.UTF-8 2>&1 >> /var/log/provision.log

echo "#2 Adding multiverse repositorie to sources.list..." | tee -a /var/log/provision.log
echo "deb http://archive.ubuntu.com/ubuntu precise universe main multiverse restricted" > /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu/ precise-security universe main multiverse restricted" >> /etc/apt/sources.list
apt-get update 2>&1 >> /var/log/provision.log

echo "#3 Upgrading system..." | tee -a /var/log/provision.log
apt-get -y upgrade 2>&1 >> /var/log/provision.log

echo "#4 Installing Apache2..." | tee -a /var/log/provision.log
apt-get -y install apache2 2>&1 >> /var/log/provision.log
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

echo "#5 Installing PHP5.3..." | tee -a /var/log/provision.log
apt-get -y install libapache2-mod-php5 2>&1 >> /var/log/provision.log
echo '<?php phpinfo(); ?>' > /var/www/index.php

echo "#6 Installing PHP Extensions..." | tee -a /var/log/provision.log
apt-get -y install php5-mysql php5-memcached php5-geoip php5-gd php5-mcrypt 2>&1 >> /var/log/provision.log

echo "#6 Tidying up..." | tee -a /var/log/provision.log
chmod -R 600 /etc/update-motd.d/*
apt-get -y remove cloud-init 2>&1 >> /var/log/provision.log

echo "#7 Provision done, machine ready." | tee -a /var/log/provision.log
echo -e "IP: \c" && ifconfig eth1 | grep "inet " | cut -d ':' -f2 | awk '{print $1}'