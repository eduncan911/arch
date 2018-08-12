#!/bin/bash

# Usage:
#   20-partition.sh /dev/sda

if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "  20-partition.sh /dev/sda"
    echo ""
    echo "Use 'lsblk' or 'fdisk -l' to find the disk."
    echo ""
    exit 2
fi

DISK="$1"
BOOT="${DISK}1"
ROOT="${DISK}2"

echo "partitioning $DISK"
parted --script $DISK \
    mklabel gpt \
    mkpart ESP fat32 1MiB 551MiB \
    set 1 esp on \
    mkpart primary ext4 551MiB 8000MiB

echo "formatting $BOOT as fat32 for /boot"
mkfs.fat -n boot -F32 $BOOT

echo "formatting $ROOT as ext4 for /"
mkfs.ext4 -L root $ROOT

echo "mounting /mnt as a root"
mount $ROOT /mnt

echo "mounting /mnt/boot as boot"
mkdir /mnt/boot
mount $BOOT /mnt/boot

