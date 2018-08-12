#!/bin/bash

# Usage:
#   40-chroot.sh HOST_NAME
#
#   If using DHCP, set STATIC_IP to 127.0.1.1

if [ $# -ne 3 ]; then
    echo "Usage:"
    echo "  40-chroot.sh HOST_NAME DOMAIN ROOT_PASSWD"
    echo ""
    exit 4
fi

HOST_NAME="$1"
DOMAIN="${2}"
PASSWD_ROOT="${3}"
STATIC_IP="127.0.1.1"

NETWORK_DEVICES=""
for n in `ls /sys/class/net`; do
  [ "${n}" == "lo" ] && continue
  
  if [ "${NETWORK_DEVICES}" != "" ]; then
    NETWORK_DEVICES="${NETWORK_DEVICES},${n}"
  else
    NETWORK_DEVICES="${n}"
  fi
done

echo "######################################"
echo "## arch-chroot /mnt ./chroot.sh ${HOST_NAME} ${DOMAIN} PASS ${NETWORK_DEVICES}"
echo "######################################"
cp scripts/chroot.sh /mnt
arch-chroot /mnt ./chroot.sh ${HOST_NAME} ${DOMAIN} "${PASSWD_ROOT}" "${NETWORK_DEVICES}"
rm /mnt/chroot.sh

echo "######################################"
echo "## finish setting up systemd-boot"
echo "######################################"
mkdir -p /mnt/boot/loader /mnt/boot/loader/entries

cat > /mnt/boot/loader/loader.conf << EOF
default  arch
timeout  4
EOF

ROOT_DISK=`lsblk -l -o NAME,MOUNTPOINT | egrep "/mnt$" | cut -f 1 -d " "`
#ROOT_UUID=`ls -l /dev/disk/by-partuuid/ | grep ${ROOT_DISK} | awk '{print $9}'`

cat > /mnt/boot/loader/entries/arch.conf << EOF
title   Arch Linux
linux   /vmlinuz-linux
#initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=/dev/${ROOT_DISK} rootfstype=ext4 rw add_efi_memmap
EOF

cat > /mnt/boot/loader/entries/arch-recovery.conf << EOF
title   Arch Linux (Recovery)
linux   /vmlinuz-linux
#initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=/dev/${ROOT_DISK} rootfstype=ext4 rw add_efi_memmap init=/bin/sh
EOF
