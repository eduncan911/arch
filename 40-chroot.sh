#!/bin/bash

# Usage:
#   40-chroot.sh HOST_NAME STATIC_IP
#
#   If using DHCP, set STATIC_IP to 127.0.1.1

if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "  40-chroot.sh NETWORK_DEVICE HOST_NAME STATIC_IP"
    echo ""
    echo "'ip a' to list interfaces."
    echo ""
    echo "If using DHCP, set STATIC_IP to 127.0.1.1"
    echo ""
    exit 4
fi

NETWORK_DEVICE=$1
HOST_NAME=$2
STATIC_IP=$3

echo "running chroot"
cp ./chroot.sh /mnt
arch-chroot /mnt ./chroot.sh ${NETWORK_DEVICE} ${HOST_NAME} ${STATIC_IP}
rm /mnt/chroot.sh

echo "configuring bootloader entries"
mkdir -p /mnt/boot/loader /mnt/boot/loader/entries

cat > /mnt/boot/loader/loader.conf << EOF
default  arch
timeout  2
editor   no
EOF

BOOT_DISK=`lsblk -l -o NAME,MOUNTPOINT | egrep "/mnt$" | cut -f 1 -d " "`
#BOOT_UUID=`ls -l /dev/disk/by-partuuid/ | grep ${BOOT_DISK} | awk '{print $9}'`

cat > /mnt/boot/loader/entries/arch.conf << EOF
title   Arch Linux
linux   /vmlinuz-linux
#initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=/dev/${BOOT_DISK} rootfstype=ext4 rw add_efi_memmap
EOF

cat > /mnt/boot/loader/entries/arch-recovery.conf << EOF
title   Arch Linux (Recovery)
linux   /vmlinuz-linux
#initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=/dev/${BOOT_DISK} rootfstype=ext4 rw add_efi_memmap init=/bin/sh
EOF

echo ""
echo "A basic Arch Linux installation is complete. Before rebooting, you may"
echo "want to re-configure a few things such as networking."
echo ""
echo "  /mnt/etc/systemd/network"
echo ""
echo "Is this an Intel machine?  Install the microcode for it."
echo ""
echo "  50-intel-microcode.sh"
echo ""
echo "And then uncomment the line in /mnt/boot/loader/entries/arch.conf"
echo ""

