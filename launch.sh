#!/bin/sh

echo "██████╗░██╗░░░░░░░█████╗░░█████╗░███╗░░██╗███████╗██╗░██████╗░"
echo "██╔══██╗██║░░░░░░██╔══██╗██╔══██╗████╗░██║██╔════╝██║██╔════╝░"
echo "██████╔╝██║█████╗██║░░╚═╝██║░░██║██╔██╗██║█████╗░░██║██║░░██╗░"
echo "██╔═══╝░██║╚════╝██║░░██╗██║░░██║██║╚████║██╔══╝░░██║██║░░╚██╗"
echo "██║░░░░░██║░░░░░░╚█████╔╝╚█████╔╝██║░╚███║██║░░░░░██║╚██████╔╝"
echo "╚═╝░░░░░╚═╝░░░░░░░╚════╝░░╚════╝░╚═╝░░╚══╝╚═╝░░░░░╚═╝░╚═════╝░"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""

sleep 1

if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse con privilegios de administrador (root)." >&2
    exit 1
else
    echo "asegurarse de tener contraseña en root"
fi

username=`whoami`

echo "Interface:"
read interface

echo "introducir direcciones para logs por telegram (y/n):"
read c_telegram

if [ $c_telegram = "y" ]
then
    echo "bot_token:"
    read bot_token
    echo "group_id:"
    read group_id
    sed -i "s/!!!bot_token!!!/$bot_token/g" mails/config.py
    sed -i "s/!!!group_id!!!/$group_id/g" mails/config.py
    echo "@reboot python /etc/telegram/start.py" >> crontab
    echo 'python /etc/telegram/enviar-ssh.py' >> /home/$username/.bashrc 
    echo 'python /etc/telegram/enviar-root.py' >> /root/.bashrc 

    cp telegram /etc/ -R
    pip install python-telegram-bot
    pip install sys
    pip install telegram
    pip install schedule
    pip install python-telegram-bot
fi   

ip=`/usr/sbin/ifconfig $interface | grep "inet " | awk '{print $2}'`

dir=$pwd
home=/home/$username

echo "[ APT ]"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""

sleep 1

echo "deb http://deb.debian.org/debian buster main" >> /etc/apt/sources.list
apt -y update 
apt -y install apache2 apache2-utils php neovim acl hugo snapd docker unzip 
apt-get install -y libapache2-mod-geoip
a2enmod geoip
apt -y dist-upgrade

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
docker pull klakegg/hugo

echo "[ APT OK ]"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""
sleep 1
cls

echo "[ DUCK ]"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""

sleep 1

mkdir ~/duckdns
mv ./duck.sh ~/duckdns
chmod 755 ~/duckdns/duck.sh

sh ~/duckdns/duck.sh

echo "[ DUCK OK ]"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""
sleep 1
cls

echo "[ SSH ]"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""

sleep 1

echo "PASSWORD FOR HTML USER"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""
adduser html --home /var/www/html

groupadd usuarios
usermod -a -G usuarios html
usermod -a -G usuarios $username


cp ./hugo.sh ~/
sed -i "s/!!!IP!!!/$ip/g" ~/hugo.sh
chown root ~/hugo.sh
chmod 755 ~/hugo.sh
cp ./html /var/www -R 
chmod g+w /var/www/html -R

chown -R html /var/www/html
chgrp -R usuarios /var/www/html

setfacl -m user:html:--- /usr/bin/su
setfacl -m user:html:--- /usr/bin/
systemctl restart ssh 

echo "[ SSH OK ]"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""
sleep 1
cls

echo "[ HTML ]"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""

sleep 1

rm /var/www/html/index.html
cd /var/www/html
mkdir files
mkdir filesPrivate
hugo new site hugo
cd hugo
git init
git submodule add https://github.com/alex-shpak/hugo-book themes/hugo-book
echo "theme = 'hugo-book'" >> config.toml

cd $dir

chown -R html /var/www/html
chgrp -R usuarios /var/www/html

cp ./rc.local /etc/rc.local
sed -i "s/!!!IP!!!/$ip/g" ./crontab
sed -i "s/!!!USER!!!/$username/g" ./crontab
cp ./crontab /var/spool/cron/crontabs/root

cp ./000-default.conf /etc/apache2/sites-enabled
echo "PASSWORD FOR PUBLIC:"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""
htpasswd -c /etc/apache2/.htpasswd Public
echo "$username"
htpasswd /etc/apache2/.htpasswd $username
echo "$username"
htpasswd -c /etc/apache2/.htpasswdPrivate $username

echo "User html" >> /etc/apache2/apache2.conf

systemctl restart apache2 
sed -i "s/!!!USER!!!/$username/g" /etc/rc.local

cp -r ./apache2 /etc/ 
systemctl restart apache2 

echo "[ HTML OK ]"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""
sleep 1
cls

echo "[ PIVPN ]"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""

sleep 1

curl -L https://install.pivpn.io | bash

ipvpn=`ip addr | grep '10\.' | awk '{print $2}'`
iptables -t nat -A POSTROUTING -s $ipvpn -o $interface -j MASQUERADE

echo "[ PIVPN OK ]"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo ""
sleep 1
cls


echo "[ Permisos ]"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"

sed -i "/^$username/d" /etc/rs
echo "Los permisos de para el usuario $username se han eliminado correctamente."
chmod 700 /usr/bin/sudo

echo "[ Permisos OK ]"
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"