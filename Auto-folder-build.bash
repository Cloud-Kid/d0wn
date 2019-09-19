#!/bin/bash
# This script will create the directories and sub-directories needed for this project
#
#
# chmod +x <scriptfilename>
# Usage: ./<scriptfilename>

#Create basic folders for deployement
mkdir ~/Docker
mkdir ~/Docker/Services
mkdir ~/Docker/Storage
mkdir ~/Docker/Storage/Data
mkdir ~/Docker/Storage/Medias
mkdir ~/Docker/Storage/Medias/Movies
mkdir ~/Docker/Storage/Medias/Shows
mkdir ~/Docker/Storage/Medias/Music
mkdir ~/Docker/Storage/Data/Nextcloud
mkdir ~/Docker/Storage/Data/Others

#List of available services
services[0]="portainer";
services[1]="organizr";
services[2]="nextcloud";
services[3]="phpmyadmin";
services[4]="tautulli";
services[5]="plex";
services[6]="traefik";
services[7]="watchtower";
services[8]="mariadb";

#Ask to the user wich services he want to install
for service in ${services[*]}
do
echo $service;

echo -n "Would you like to install $service ? y/n"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    echo "$service"
    mkdir ~/Docker/Services/$service
    echo "Ok"
elif [ "$answer" = "n" ] || [ "$answer" = "N" ]; then
    echo " "
else
    echo "You need to type Y or N not $answer"
fi

done

#Environnement variable input
echo "WORKDIR=~/Docker/Services"


#Domain name
echo "What's your domain name ? "
read DOMAINNAME
echo "DOMAINNAME=$DOMAINNAME" >> /etc/environment

#Time Zone
echo "Set your timezone ? "
read TZ
echo "TZ=$TZ" >> /etc/environment

#MYSQL Root password
echo "Choose your MYSQL root password : "
read MYSQLROOT
echo "MYSQL_ROOT_PASSWORD=$MYSQLROOT" >> /etc/environment

#Cloudflare email
echo "Enter your cloudflare email : "
read CLOUDFLAREMAIL
echo "CLOUDFLARE_EMAIL=$CLOUDFLAREMAIL" >> /etc/environment

#Cloudflare API Key
echo "Enter your cloudflare API Key : "
read CLOUDFLAREAPI
echo "CLOUDFLARE_API_KEY=$CLOUDFLAREAPI" >> /etc/environment
