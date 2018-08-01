#!/bin/bash

# Usage:
#   30-bootstrap.sh

if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "  30-bootstrap.sh"
	exit 3
fi

echo "bootstrapping /mnt"
pacstrap /mnt base bash

echo "generating fstab"
genfstab -U /mnt > /mnt/etc/fstab
echo "################"
cat /mnt/etc/fstab
echo "################"

