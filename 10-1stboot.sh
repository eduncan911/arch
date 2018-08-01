#!/bin/bash

# Usage:
#   10-1stboot.sh

echo "setfont to sun12x22"
setfont /usr/share/kbd/consolefonts/sun12x22.psfu.gz

echo "update time"
timedatectl set-ntp true
timedatectl status

