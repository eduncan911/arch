#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage:"
    echo "  60-chroot.sh USER PASS"
    echo ""
    exit 4
fi

AUSER="$1"
PASSWD_USER="$2"

echo "######################################"
echo "## arch-chroot /mnt ./user.sh ${AUSER} PASS"
echo "######################################"
cp scripts/user.sh /mnt
arch-chroot /mnt ./user.sh "${AUSER}" "${PASSWD_USER}"
rm /mnt/user.sh
