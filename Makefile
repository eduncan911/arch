SHELL := /bin/bash

.DEFAULT_GOAL := usage
.PHONY: usage largefont base xen usb server desktop

USER ?= "eric"
DISK ?= "/dev/sda"
PART_PREFIX ?= ""	# mmc == "p"
HOST_NAME ?= "dom0"

usage:
	@echo "Usage:"
	@echo "  make [USER=eric] [DISK=/dev/sda] [PART_PREFIX=""] [HOST=dom0] \\"
	@echo "       [largefont|base|usb]"
	@echo ""
	@echo "Example:"
	@echo "  make DISK=/dev/mmcblk0 PART_PREFIX="p" largefont base"
	@echo ""
	@echo "After reboot, you may further configure with:"
	@echo "  make [xen|server|desktop]"
	@echo ""

.largefont:
	setfont /usr/share/kbd/consolefonts/sun12x22.psfu.gz

.base:
	scripts/10-1stboot.sh && \
	scripts/20-partition.sh $(DISK) $(PART_PREFIX) && \
	scripts/30-bootstrap.sh && \
	scripts/40-chroot.sh $(HOST_NAME) && \
	scripts/60-user.sh $(USER)

.usb:
	@:

.xen:
	scripts/99-setup-xen.sh $(USER)

.server:
	@:

.desktop:
	@:
