#!/bin/bash

# Usage:
#   40-chroot.sh HOST_NAME STATIC_IP
#
#   If using DHCP, set STATIC_IP to 127.0.1.1

if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "  40-chroot.sh NETWORK_DEVICE HOST_NAME STATIC_IP"
    echo ""
    echo "If using DHCP, set STATIC_IP to 127.0.1.1"
    exit 4
fi

NETWORK_DEVICE=$1
HOST_NAME=$2
STATIC_IP=$3

echo "running chroot"
arch-chroot /mnt ./chroot.sh ${NETWORK_DEVICE} ${HOST_NAME} ${STATIC_IP}

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
echo "You may reboot at any time."
echo ""

