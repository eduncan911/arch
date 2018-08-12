#!/bin/bash

USER=${USER:="eric"}
DISK=${DISK:="/dev/sda"}
PART_PREFIX=${PART_PREFIX:=""}  # mmc == "p"
HOST_NAME=${HOST_NAME:="dom0"}
DOMAIN=${DOMAIN:="loghome"}

#   Usage:
#       ./go.sh
# 
#   Example:
#       DISK=/dev/mmcblk0 && PART_PREFIX="p" ./go.sh
#

#   Setup a large font:
#       setfont /usr/share/kbd/consolefonts/sun12x22.psfu.gz

echo "######################################"
echo "## downloading scripts"
echo "######################################"
#wget -q -O 10-1stboot.sh https://raw.githubusercontent.com/eduncan911/arch-setup/master/10-1stboot.sh
#wget -q -O 20-partition.sh https://raw.githubusercontent.com/eduncan911/arch-setup/master/20-partition.sh
#wget -q -O 30-bootstrap.sh https://raw.githubusercontent.com/eduncan911/arch-setup/master/30-bootstrap.sh
#wget -q -O 40-chroot.sh https://raw.githubusercontent.com/eduncan911/arch-setup/master/40-chroot.sh
#wget -q -O 50-intel-microcode.sh https://raw.githubusercontent.com/eduncan911/arch-setup/master/50-intel-microcode.sh
#wget -q -O chroot.sh https://raw.githubusercontent.com/eduncan911/arch-setup/master/chroot.sh
#chmod 755 *.sh
rm -rf arch-master*
pacman --noconfirm -Sy unzip
wget -qO arch-master.zip https://github.com/eduncan911/arch/archive/master.zip
unzip arch-master.zip
cd arch-master
scripts/10-1stboot.sh && \
scripts/20-partition.sh ${DISK} ${PART_PREFIX} && \
scripts/30-bootstrap.sh && \
scripts/40-chroot.sh ${HOST_NAME} ${DOMAIN} && \
scripts/60-user.sh ${USER}
