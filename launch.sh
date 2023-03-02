#!/bin/sh

username=`whoami`

echo "Interface:"
read interface

ip="/usr/sbin/ifconfig $interface | grep "inet " | awk '{print $2}'"

dir=$pwd
home=/home/$username

echo "[ APT ]"

echo "deb http://deb.debian.org/debian buster main" >> /etc/apt/sources.list
sudo apt -y update 
sudo apt -y install apache2 apache2-utils php neovim acl hugo snapd docker unzip 
sudo apt-get install -y libapache2-mod-geoip
a2enmod geoip
sudo apt -y dist-upgrade

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
docker pull klakegg/hugo

echo "[ APT OK ]"

echo "[ DUCK ]"

mkdir ~/duckdns
mv ./duck.sh ~/duckdns
chmod 700 ~/duckdns/duck.sh

sh ~/duckdns/duck.sh

echo "[ DUCK OK ]"

echo "[ SSH ]"

echo "PASSWORD FOR HTML USER"
sudo adduser html --home /var/www/html

sudo groupadd usuarios
sudo usermod -a -G usuarios html
sudo usermod -a -G usuarios $username


cp ./hugo.sh ~/
chmod a+x ~/hugo.sh
sudo cp ./html /var/www -R 
sudo chmod g+w /var/www/html -R

sudo chown -R html /var/www/html
sudo chgrp -R usuarios /var/www/html

sudo cp ./sshd_config_2019 /etc/ssh/
sudo /usr/sbin/sshd -f sshd_config_2019

sudo setfacl -m user:html:--- /usr/bin/su
sudo setfacl -m user:html:--- /usr/bin/sudo

sudo systemctl restart ssh 

echo "[ SSH OK ]"

echo "[ HTML ]"

sudo rm /var/www/html/index.html
cd /var/www/html
mkdir files
mkdir filesPrivate
hugo new site hugo
cd hugo
git init
git submodule add https://github.com/alex-shpak/hugo-book themes/hugo-book
echo "theme = 'hugo-book'" >> config.toml

cd $pwd

sudo chown -R html /var/www/html
sudo chgrp -R usuarios /var/www/html

sudo cp ./rc.local /etc/rc.local
sudo cp ./crontab /var/spool/cron/crontabs/$username

sudo cp ./000-default.conf /etc/apache2/sites-enabled
echo "PASSWORDS FOR:"
echo "Public"
sudo htpasswd -c /etc/apache2/.htpasswd Public
echo "$username"
sudo htpasswd /etc/apache2/.htpasswd $username
echo "$username"
sudo htpasswd -c /etc/apache2/.htpasswdPrivate $username

sudo echo "User html" >> /etc/apache2/apache2.conf

sudo systemctl restart apache2 
sed -i "s/!!!USER!!!/$username/g" /etc/rc.local
sed -i "s/!!!USER!!!/$username/g" /var/spool/cron/crontabs/$username
sed -i "s/!!!USER!!!/$username/g" ~/hugo.sh

echo "[ HTML OK ]"

echo "[ PIVPN ]"

curl -L https://install.pivpn.io | bash

echo "[ PIVPN OK ]"

