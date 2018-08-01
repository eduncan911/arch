#!/bin/bash

# Usage:
#   10-1stboot.sh

echo "setfont to sun12x22"
setfont /usr/share/kbd/consolefonts/sun12x22.psfu.gz

echo "update time"
timedatectl set-ntp true
timedatectl status

echo "downloading the remaining scripts"
wget -q -O 20-partition.sh https://raw.githubusercontent.com/eduncan911/arch-setup/master/20-partition.sh
wget -q -O 30-bootstrap.sh https://raw.githubusercontent.com/eduncan911/arch-setup/master/30-bootstrap.sh
wget -q -O 40-chroot.sh https://raw.githubusercontent.com/eduncan911/arch-setup/master/40-chroot.sh
wget -q -O 50-intel-microcode.sh https://raw.githubusercontent.com/eduncan911/arch-setup/master/50-intel-microcode.sh
wget -q -O chroot.sh https://raw.githubusercontent.com/eduncan911/arch-setup/master/chroot.sh
chmod 755 *.sh
