#!/bin/bash

# Usage:
#   30-bootstrap.sh

echo "######################################"
echo "## pacstrap /mnt base bash"
echo "######################################"
pacstrap /mnt base bash

echo "######################################"
echo "## genfstab /mnt"
echo "######################################"
genfstab /mnt > /mnt/etc/fstab

echo "######################################"
cat /mnt/etc/fstab
echo "######################################"
