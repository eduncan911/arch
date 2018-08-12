#!/bin/bash

echo "######################################"
echo "## pacman -Syu sudo git openssh curl wget htop tree vim"
echo "######################################"
cp scripts/user.sh /mnt
arch-chroot /mnt ./user.sh ${USER}
rm /mnt/user.sh
