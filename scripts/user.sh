#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage:"
    echo "  user.sh USER PASS"
    exit 3
fi

USER="$1"
PASSWD_USER="$2"

echo "######################################"
echo "## useradd -m ${USER}"
echo "######################################"
useradd -m ${USER}

echo "######################################"
echo "## passwd ${USER}"
echo "######################################"
echo "${USER}:${PASSWD_USER}" | chpasswd
