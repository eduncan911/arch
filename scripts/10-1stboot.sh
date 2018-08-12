#!/bin/bash

# Usage:
#   10-1stboot.sh

echo "######################################"
echo "## timedatectl"
echo "######################################"
timedatectl set-ntp true
timedatectl status
