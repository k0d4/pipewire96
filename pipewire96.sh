#!/bin/sh
#  This script will install pipewire.conf to /etc/pipewire/pipewire.conf, 
#  pipewire-pulse.conf to /etc/pipewire/pipewire-pulse.conf, 
#  and 50-alsa-config.lua to /etc/wireplumber/main.lua.d/50-alsa-config.lua

echo 'This script will install *system wide* support for 96kHz output and upsampling with Pipewire and Wireplumber. '
read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
if [ ! -f /usr/bin/pipewire ] ; then echo 'Pipewire not found'
exit
fi
if [ ! -f /usr/bin/wireplumber ] ; then echo 'Wireplumber not found'
exit
fi
pushd /tmp
git clone https://gist.github.com/743077ed4dc81435844362daf004c565.git
git clone https://gist.github.com/f5abca914308384246e3421468ce3f3f.git
git clone https://gist.github.com/2a342e7ab9bc1d06d131bcf3b6b26133.git
sudo mkdir -p /etc/wireplumber/main.lua.d
if [ -f /etc/pipewire/pipewire.conf ] ; then echo '/etc/pipewire/pipewire.conf exists'
fi
while true; do
    read -p "Do you wish to overwrite this file? " yn
    case $yn in
        [Yy]* ) sudo cp /tmp/2a342e7ab9bc1d06d131bcf3b6b26133/pipewire.conf /etc/pipewire/ && sudo chmod 755 /etc/pipewire/pipewire.conf ; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer y / n?";;
    esac
done
if [ -f /etc/pipewire/pipewire-pulse.conf ] ; then echo '/etc/pipewire/pipewire-pulse.conf exists'
fi
while true; do
    read -p "Do you wish to overwrite this file? " yn
    case $yn in
        [Yy]* ) sudo cp /tmp/f5abca914308384246e3421468ce3f3f/pipewire-pulse.conf /etc/pipewire/ && sudo chmod 755 /etc/pipewire/pipewire-pulse.conf ; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer y / n?";;
    esac
done
if [ -f /etc/wireplumber/main.lua.d/50-alsa-config.lua ] ; then echo '/etc/wireplumber/main.lua.d/50-alsa-config.lua exists'
fi
while true; do
    read -p "Do you wish to overwrite this file? " yn
    case $yn in
        [Yy]* ) sudo cp /tmp/743077ed4dc81435844362daf004c565/50-alsa-config.lua /etc/wireplumber/main.lua.d/ && sudo chmod 755 /etc/wireplumber/main.lua.d/50-alsa-config.lua ; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer y / n?";;
    esac
done
echo "Finished."
popd
