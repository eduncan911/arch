#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "  chroot.sh NETWORK_DEVICE HOST_NAME STATIC_IP"
    exit 3
fi

NETWORK_DEVICE=$1
HOST_NAME=$2
STATIC_IP=$3

echo "installing additional packages"
pacman -Sy git openssh curl wget htop

echo "setting timezone"
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

echo "update hwclock"
hwclock --systohc

echo "setting localization"
sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "setting hostname to ${HOST_NAME} for ${STATIC_IP}"
echo "${HOST_NAME}" > /etc/hostname
cat > /etc/hosts << EOF
127.0.0.1  localhost
::1        localhost
${STATIC_IP}  ${HOST_NAME}.loghome ${HOST_NAME}
EOF

echo "set a root password"
passwd

echo "configure networking"
cat > /etc/systemd/network/20-primary.network << EOF
[Match]
Name=${NETWORK_DEVICE}

#[DHCP]
#RouteMetric=10

#[Route]
#Gateway=10.88.88.1
#Metric=10

#[Address]
#Address=${STATIC_IP}/24

#[Network]
#DNS=10.88.88.1
DHCP=ipv4
EOF

systemctl enable systemd-networkd.service

echo "installing bootloader"
bootctl --path=/boot install

