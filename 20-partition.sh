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
BOOT="${DISK}p1"
ROOT="${DISK}p2"

echo "partitioning $DISK"
parted --script $DISK \
    mklabel gpt \
    mkpart ESP fat32 1MiB 551MiB \
    mkpart primary ext4 551MiB 8000MiB

echo "formatting $BOOT as fat32 for /boot"
mkfs.fat -F32 $BOOT

echo "formatting $ROOT as ext4 for /"
mkfs.ext4 $ROOT

echo "mounting /mnt as a root"
mount $ROOT /mnt

echo "mounting /mnt/boot as boot"
mkdir /mnt/boot
mount $BOOT /mnt/boot

