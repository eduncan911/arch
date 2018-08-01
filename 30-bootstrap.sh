#!/bin/bash

# Usage:
#   30-bootstrap.sh

echo "bootstrapping /mnt"
pacstrap /mnt base bash

echo "generating fstab"
genfstab -U /mnt > /mnt/etc/fstab
echo "################"
cat /mnt/etc/fstab
echo "################"

