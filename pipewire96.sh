#!/usr/bin/env bash
#  pipewire96-system.sh version 1.0 by k0d4
#  This script will install pipewire.conf to /etc/pipewire/pipewire.conf,
#  pipewire-pulse.conf to /etc/pipewire/pipewire-pulse.conf,
#  and 50-alsa-config.lua to /etc/wireplumber/main.lua.d/50-alsa-config.lua
if [ "$EUID" -ne 0 ]
  then echo "Please run as root/sudo"
  exit
fi

echo 'This script will install *system wide* support for 96kHz output and upsampling with Pipewire and Wireplumber. '
read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
if [ ! -f /usr/bin/pipewire ] ; then echo 'Pipewire not found'
exit
fi
if [ ! -f /usr/bin/wireplumber ] ; then echo 'Wireplumber not found'
exit
fi
chmod 755 ./50-alsa-config.lua
chown root:root ./50-alsa-config.lua
chmod 755 ./pipewire.conf
chown root:root ./pipewire.conf
chmod 755 ./pipewire-pulse.conf
chown root:root ./pipewire-pulse.conf
mkdir -p /etc/wireplumber/main.lua.d

if [ -f /etc/pipewire/pipewire.conf ] ; then echo "File exists, do you wish to replace it?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) cp -avf ./pipewire.conf /etc/pipewire/ ; break;;
        No ) exit;;
    esac
done
fi
cp -avf ./pipewire.conf /etc/pipewire

if [ -f /etc/pipewire/pipewire-pulse.conf ] ; then echo  "File exists, do you wish to replace it?"
select yn in "Yes" "No"; do 
 case $yn in
        Yes ) cp -avf ./pipewire-pulse.conf /etc/pipewire/ ; break;;
        No ) exit;;
    esac
done
fi
cp -avf ./pipewire-pulse.conf /etc/pipewire

if [ -f /etc/wireplumber/main.lua.d/50-alsa-config.lua ] ; then echo "File exists, do you wish to replace it?"
select yn in "Yes" "No"; do 
 case $yn in 
        Yes ) cp -avf ./50-alsa-config.lua /etc/wireplumber/main.lua.d/ ; break;;
        No ) exit;;
    esac
done
fi
cp -avf ./50-alsa-config.lua /etc/wireplumber/main.lua.d/

echo "Finished."
