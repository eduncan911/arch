# Setup Arch Linux

I have installed Arch far too many times than I can remember for many years.  I highly prefer Arch on everything including most of my embedded devices(Raspberry Pi, UP Board, UP Squared) of which I have a few dozen in the collection.

To help speed up the process, this repository holds a set of defaults to self-configure my devices.

## DISCLAIMER

**You do not want to use this repo as-is.**  You want to follow The Arch Way and install ArchLinux following the extremely methodical and accurate Arch Wiki:

https://wiki.archlinux.org/index.php/Installation_guide

Only after you've install Arch a few dozen times across different embedded, ARM and PC devices will you have the knowledge of the subtle differences between these platforms, storage and network configurations and why these files in this repo are ordered the way they are.

## They were built for my Homelab

These scripts currently use:

* systemd-boot (EFI only) on fat32 partition 1
* 8 GB root / ext4 partition 2
* no swapfile
* DHCP for all detected NICs (if any), else sample config is written

## Fork Me

Feel free to fork it and tweak the settings to your taste.

## Future Eric

Quickstart:

   wget -q https://github.com/eduncan911/arch/archive/master.zip
   pacman --noconfirm -Syu unzip
   unzip master.zip
   cd arch-master/
