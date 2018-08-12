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
DISK_PREFIX="$2"
BOOT="${DISK}${PART_PREFIX}1"
ROOT="${DISK}${PART_PREFIX}2"

echo "######################################"
echo "### parted $DISK for an 8GB / root"
echo "######################################"
parted --script $DISK \
    mklabel gpt \
    mkpart ESP fat32 1MiB 551MiB \
    set 1 esp on \
    mkpart primary ext4 551MiB 8000MiB

echo "######################################"
echo "## mkfs.fat -n boot -F32 $BOOT"
echo "######################################"
mkfs.fat -n boot -F32 $BOOT

echo "######################################"
echo "## mkfs.ext4 -L root $ROOT"
echo "######################################"
mkfs.ext4 -L root $ROOT

echo "######################################"
echo "## mount $ROOT /mnt"
echo "######################################"
mount $ROOT /mnt

echo "######################################"
echo "## mount $BOOT /mnt/boot"
echo "######################################"
mkdir /mnt/boot
mount $BOOT /mnt/boot
