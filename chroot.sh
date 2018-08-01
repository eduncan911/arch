#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "  chroot.sh HOST_NAME STATIC_IP"
    exit 3
fi

HOST_NAME=$1
STATIC_IP=$2

echo "\ninstalling additional packages"
pacman -S git openssh curl wget htop

echo "\nsetting timezone"
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

echo "\nupdate hwclock"
hwclock --systohc

echo "\nsetting localization"
sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "\nsetting hostname to ${HOST_NAME} for ${STATIC_IP}"
echo "${HOST_NAME}" > /etc/hostname
cat > /etc/hosts << EOF
127.0.0.1  localhost
::1        localhost
${STATIC_IP}  ${HOST_NAME}.loghome ${HOST_NAME}
EOF

echo "\nset a root password"
passwd

echo "\nconfigure networking"
cat > /etc/systemd/network/20-wired.network << EOF
[Match]
Name=enp1s0

#[DHCP]
#RouteMetric=10

#[Route]
#Gateway=10.1.88.1
#Metric=10

#[Address]
#Address=10.1.88.9/24

#[Network]
#DNS=10.1.88.1
DHCP=ipv4
EOF

cat > /etc/systemd/network/25-wireless.network << EOF
[Match]
Name=wan1s0

[DHCP]
RouteMetric=20

#[Route]
#Gateway=10.1.88.1
#Metric=10

#[Address]
#Address=10.1.88.9/24

#[Network]
#DNS=10.1.88.1
DHCP=ipv4
EOF

systemctl enable systemd-networkd.service

echo "\ninstalling bootloader"
bootctl --path=/boot install
