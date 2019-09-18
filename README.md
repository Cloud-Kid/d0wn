# d0wn
d0wn - Docker OWN Server

A personnal docker server

This project allow you to deploy several services on your network with docker containers, you just have to pick the one you want and stick them together !

############## My configuration ##############

OS : Ubuntu 18.04.3 LTS
CPU : Intel i5 XXX w/ Stock cooler
Motherboard : Mortar Arctic XXX
RAM : 8Gb Corsair Value Select
Powerbrick : XXX
Case : XXX
Disks : 120G Kingston SSD (OS), 2x4Tb Red Barracuda Drives (Medias) 2x1Tb Green Barracuda Drives (Important Stuff/Configs/RAID 1 MIRROR)

##############################################

1- Create a bootable USB Stick for your server with your favorite OS

NOTE : I'M USING UBUNTU SERVER

Find your best 8G USB Stick

Download the latest ISO image of Ubuntu on their official website :

Choose one :
Ubuntu Desktop : Ubuntu w/ Graphical interface - Use this one if you plan to use a screen on your server

Ubuntu Server : Command-line interface ONLY (You can download a graphical environnement afterwards)

Official download page : https://ubuntu.com/#download

Now you have the image, you need a tool to make your USB stick bootable

I personnaly love Balena Etcher : https://www.balena.io/etcher/ (It's open source :)

Open your flashing program, select your USB, select your OS image and flash it !

Now your USB is ready we can install the OS on the server


2- Install Ubuntu & making directory tree

Now you can connect your USB to your fresh server, power it up and spam your boot option button on the keyboard, usually F11, F12, ...

Now you can see the Ubuntu installer menu select the normal install and follow the instructions, it's pretty straightforward ;)

After the installation of Ubuntu you need to create the global organisation of your folders and services, you can create your folder tree following this plan :

~/Docker_______
    |         |
Services    Storage_________ Data______________________________________
    |           |                           |                 |        \
SERVICENAME  Medias_____________        Nextcloud           Other      ...
    |           |       |       |
CONFIG.FILES  Movies   Shows  Music

3- Update your packages and Install Docker

Let's update the list of the available packets
  sudo apt update
  sudo apt upgrade

Snap should be installed by default

Now let's install docker
  sudo snap install docker
  sudo apt-get install docker-compose

If snap is not installed
  sudo apt update
  sudo apt install snapd

Good you now have a fresh up-to-date Ubuntu server with a docker daemon running !

Try docker to check if he was installed correctly by running the hello-world image
  docker run hello-world

4- Define your environnement

What's gonna make you server YOUR server is your environnement : YOUR own IP, YOUR passwords, ...

All of these informations are stored on your server in your environnement file, that's what gonna make the deployement easy because you only need to enter these informations once after that, a generic name is given to these environnement variables

EXAMPLE :
If I put the following line in my environnement file "mypassword123=PASSWORD", my password is called everytime I type $PASSWORD

Now we need to edit your environnement file !

Edit the /etc/environnement file and complete it with your informations

PUID=                    | The result of the "id" command
PGID=                    | The result of the "id" command
TZ=                      | Timezone, you can check your in the IANA TZ Database or following this link https://en.wikipedia.org/wiki/Tz_database
WORKDIR=                 | The directory where your config files should be (~/Docker/Services/ In this case)
MYSQL_ROOT_PASSWORD=     | SQL root password
CLOUDFLARE_EMAIL=        | your cloudlare email
CLOUDFLARE_API_KEY=      | your cloudflare API Key
DOMAINNAME=              | your domain name (If you have one)
HTTP_USERNAME=           | your generic usernanme
HTTP_PASSWORD=           | your generic password


5- Select the services you want to run !

The docker-compose with every services included can be downloaded on the GitHub project repository

List of the official supported services :

######### FRONTENDS ##########
   #Portainer - A WebUI for Containers
   #Organizer - Unified HTPC/Home Server Web Interface
   #Nextcloud - Your own cloud storage
   #Phpmyadmin - A WebUI for your MariaDB database
   #Tautulli (aka PlexPy) – Monitoring Plex Usage

######### BACKENDS ##########
   #Traefik - A reverse-proxy/load balancer for your services
   #Watchtower - Automatic Updater for your Containers/Apps
   #MariaDB – Database Server for your Apps

5- Global docker-compose rules








#Reference: https://www.smarthomebeginner.com/docker-home-media-server-2018-basic
#Requirement: Set environmental variables: WORKDIR, PUID, PGID, MYSQL_ROOT_PASSWORD, and TZ as explained in the reference.
#/media/raid = ${WORKDIR}
#     |
#/services_directories

version: "3.3"



######### UTILITIES ##########




X- Get a domain name
The easiest way to deploy these services is to use cloudflare



































XX - Nextcloud troubleshooting

If you go to the global overview in your Nextcloud settings you may encounter the following message :

" Il y a quelques avertissements concernant votre configuration.

  PROBLEME REVERSE PROXY

    La configuration du serveur web ne permet pas d'atteindre "/.well-known/caldav". Vous trouverez plus d'informations dans la documentation.
    La configuration du serveur web ne permet pas d'atteindre "/.well-known/carddav". Vous trouverez plus d'informations dans la documentation. "

That's because your Nextcloud instance is located behind a reverse-proxy (traefik), you can get more information about this warning in the Nextcloud documentation : https://docs.nextcloud.com/server/16/go.php?to=admin-setup-well-known-URL

To get over this warning you need to add your traefik ip instance in the list of trusted revers-proxys.

In order to do that you can edit your Nextcloud configuration file in your Nextcloud instance : /config/config.php

And add the following lines at the end of the configuration file :

'trusted_proxies' =>
 array (
   0 => 'YOUR.DOMAINNAME',
   1 => 'YOURSERVERPRIVATEIP',
   2 => 'localhost',
  ),

You can now restart your Nextcloud instance, the problem should be solved.
