#!/bin/sh

dir=$pwd

echo "[ APT ]"

sudo apt update 
sudo apt install apache2 apache2-utils php neovim acl hugo snapd docker -y
sudo apt dist-upgrade

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
sudo usermod -a -G usuarios b4391co

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
sudo hugo new site General

cd General
sudo git init
sudo git submodule add https://github.com/alex-shpak/hugo-book themes/hugo-book
docker pull klakegg/hugo
sudo chmod a+w config.toml
echo "theme = 'book'" >> config.toml

cd $pwd
sudo cp ./index.md /var/www/html/General/content/_index.md
cp ./hugo.sh ~
chmod a+x /home/b4391co/hugo.sh

sudo chown -R html /var/www/html
sudo chgrp -R usuarios /var/www/html

sudo cp ./rc.local /etc/rc.local

sudo cp ./000-default.conf /etc/apache2/sites-enabled
echo "PASSWORDS FOR:"
Echo "Public"
sudo htpasswd -c /etc/apache2/.htpasswd Public
Echo "b4391co"
sudo htpasswd /etc/apache2/.htpasswd b4391co
Echo "b4391co"
sudo htpasswd -c /etc/apache2/.htpasswdPrivate b4391co

sudo systemctl restart apache2 

echo "[ HTML OK ]"

echo "[ PIVPN ]"

curl -L https://install.pivpn.io | bash

echo "[ PIVPN OK ]"

