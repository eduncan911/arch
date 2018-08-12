#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage:"
    echo "  user.sh USER PASS"
    exit 3
fi

AUSER="$1"
PASSWD_USER="$2"

echo "######################################"
echo "## useradd -m ${AUSER}"
echo "######################################"
useradd -m ${AUSER}

echo "######################################"
echo "## passwd ${AUSER}"
echo "######################################"
echo "${AUSER}:${PASSWD_USER}" | chpasswd
