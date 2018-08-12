#!/bin/bash

# Usage:
#   50-intel-microcode.sh

echo "######################################"
echo "## arch-chroot /mnt pacman --noconfirm -Sy intel-ucode"
echo "######################################"
arch-chroot /mnt pacman -S intel-ucode

echo "#################################################################"
echo "## REMEMBER: Uncomment Intel parts in /boot/loader/entries/*.conf"
echo "#################################################################"
