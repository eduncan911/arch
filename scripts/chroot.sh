#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "  chroot.sh HOST_NAME DOMAIN NETWORK_DEVICES"
    exit 3
fi

HOST_NAME="$1"
DOMAIN="$2"
NETWORK_DEVICES="$3"
[ "${NETWORK_DEVICES}" == "" ] && NETWORK_DEVICES="eth0"

echo "######################################"
echo "## pacman -Sy sudo git openssh curl wget htop tree vim"
echo "######################################"
pacman --noconfirm -Sy sudo git openssh curl wget htop tree vim

echo "######################################"
echo "## localization for America/New_York UTF8"
echo "######################################"
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc   # sync time
sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "######################################"
echo "## ${HOST_NAME}.${DOMAIN} > /etc/hostname /etc/hosts"
echo "######################################"
echo "${HOST_NAME}" > /etc/hostname
cat > /etc/hosts << EOF
127.0.0.1  localhost
::1        localhost
127.0.1.1  ${HOST_NAME}.${DOMAIN} ${HOST_NAME}
EOF

echo "######################################"
echo "## configure DHCP for ${NETWORK_DEVICES}"
echo "######################################"
for n in ${NETWORK_DEVICES//,/ }; do
  [ "${n}" == "lo" ] && continue
  
  cat > "/etc/systemd/network/20-${n}.network" << EOF
[Match]
Name=${n}

# Uncomment the following lines
# for a static network configuration.

#[Route]
#Gateway=10.88.88.1
#Metric=10

#[Address]
#Address=127.0.1.1/24

[Network]
#DNS=10.88.88.1
DHCP=ipv4

# Uncomment to specify the routing order
#[DHCP]
#RouteMetric=10
EOF
done

echo "######################################"
echo "## enable systemd-networkd.service"
echo "######################################"
systemctl enable systemd-networkd.service

echo "######################################"
echo "## systemd-boot: bootctl --path=/boot install"
echo "######################################"
bootctl --path=/boot install
