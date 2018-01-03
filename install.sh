#!/bin/bash

# Copyright (c) 2017-2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


# Backup kernel and device tree blobs.
BACKUP_DIR="/root/boot_`date +%Y%m%d_%H%M%S`"
mkdir -p $BACKUP_DIR
cp -a /boot/*.dtb $BACKUP_DIR
cp -a /boot/kernel.img $BACKUP_DIR
cp -a /boot/kernel7.img $BACKUP_DIR
cp -a /boot/overlays $BACKUP_DIR


# Install firmware, modules, kernel and device tree blobs.
cp -r lib/firmware/* /lib/firmware
cp -r lib/modules/* /lib/modules
cp -r boot/* /boot
