#!/bin/sh

dir=$pwd
echo "Enter the user name: "  
read username

echo "[ APT ]"

echo "deb http://deb.debian.org/debian buster main" >> /etc/apt/sources.list
sudo apt update 
sudo apt install apache2 apache2-utils php neovim acl hugo snapd docker unzip -y
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
sudo usermod -a -G usuarios $username

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
hugo new site hugo
cd hugo
git init
git submodule add https://github.com/alex-shpak/hugo-book themes/hugo-book
echo "theme = 'hugo-book'" >> config.toml

#cp hugopages.zip /var/www/html
#cd /var/www/html
#unzip hugopages.zip
#cd hugopages
#git submodule init
#git submodule update

cd $pwd
cp ./index.md /var/www/html/hugo/content/_index.md
cp ./hugo.sh ~
#sudo cp ./docker-hugo.service /etc/systemd/system/
#sudo systemctl enable docker-hugo.service
#chmod a+x /home/$username/hugo.sh

sudo chown -R html /var/www/html
sudo chgrp -R usuarios /var/www/html

sudo cp ./rc.local /etc/rc.local
sudo cp ./crontab /var/spool/cron/crontabs/$username

sudo cp ./000-default.conf /etc/apache2/sites-enabled
echo "PASSWORDS FOR:"
Echo "Public"
sudo htpasswd -c /etc/apache2/.htpasswd Public
Echo "$username"
sudo htpasswd /etc/apache2/.htpasswd $username
Echo "$username"
sudo htpasswd -c /etc/apache2/.htpasswdPrivate $username

sudo systemctl restart apache2 

echo "[ HTML OK ]"

echo "[ PIVPN ]"

curl -L https://install.pivpn.io | bash

echo "[ PIVPN OK ]"

