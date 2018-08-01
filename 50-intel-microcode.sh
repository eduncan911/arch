#!/bin/bash

# Usage:
#   50-intel-microcode.sh

echo "running chroot"
arch-chroot /mnt pacman -S intel-ucode


