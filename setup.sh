#!/bin/sh

dir=$pwd

echo "[ APT ]"

sudo apt update 
sudo apt install apache2 apache2-utils php neovim acl hugo  -y

echo "[ APT OK ]"

echo "[ DUCK ]"

mkdir ~/duckdns
mv ./duck.sh ~/duckdns
chmod 700 ~/duckdns/duck.sh

sh ~/duckdns/duck.sh

echo "[ DUCK OK ]"

echo "[ SSH ]"

adduser -d /var/www/html html
cp ./html /var/www -R 
chown -R html /var/www/html

sudo cp ./sshd_config_2019 /etc/ssh/

setfacl -m user:html:--- /usr/bin/su
setfacl -m user:html:--- /usr/bin/sudo

sudo service ssh restart

echo "[ SSH OK ]"

echo "[ HTML ]"

cd /var/www/html 
sudo hugo new site General

cd General
git init
git submodule add https://github.com/alex-shpak/hugo-book themes/book
echo "theme = 'book'" >> config.toml

cd $pwd
cp ./index.md /var/www/html/General/content/_index.md
cp ./hugo.sh ~

echo "PASSWORDS FOR:"
Echo "Public"
sudo htpasswd -c /etc/apache2/.htpasswd Public
Echo "b4391co"
sudo htpasswd /etc/apache2/.htpasswd b4391co
Echo "b4391co"
sudo htpasswd -c /etc/apache2/.htpasswdPrivate b4391co

sudo service apache2 restart

echo "[ HTML OK ]"

echo "[ PIVPN ]"

curl -L https://install.pivpn.io | bash

echo "[ PIVPN OK ]"

