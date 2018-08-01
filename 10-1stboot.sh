#!/bin/bash

# Usage:
#   10-1stboot.sh

setfont /usr/share/kbd/consolefonts/sun12x22.psfu.gz
timedatectl set-ntp true
timedatectl status
