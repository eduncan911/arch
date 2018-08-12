#!/bin/bash

USER=${USER:="eric"}
DISK=${DISK:="/dev/sda"}
PART_PREFIX=${PART_PREFIX:=""}  # mmc == "p"
HOST_NAME=${HOST_NAME:="dom0"}

#   Usage:
#       ./go.sh
# 
#   Example:
#       DISK=/dev/mmcblk0 && PART_PREFIX="p" ./go.sh
#

#   Setup a large font:
#       setfont /usr/share/kbd/consolefonts/sun12x22.psfu.gz

scripts/10-1stboot.sh && \
scripts/20-partition.sh $(DISK) $(PART_PREFIX) && \
scripts/30-bootstrap.sh && \
scripts/40-chroot.sh $(HOST_NAME) && \
scripts/60-user.sh $(USER)
