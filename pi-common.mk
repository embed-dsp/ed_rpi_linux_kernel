
# Copyright (c) 2017 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

# FIXME:
CCPREFIX = /opt/raspberry/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-

# FIXME:
BOOT = /run/media/gb/boot
#ROOT = /run/media/gb/b105f9a8-f450-4976-8ac8-69053f57bab4
ROOT = /run/media/gb/673b8ab6-6426-474b-87d3-71bff0fcebc3


all:
	@echo "sudo make clean"
	@echo "sudo make config"
	@echo "sudo make build"
	@echo "sudo make install"


.PHONY: help
help:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} help


.PHONY: oldconfig
oldconfig:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} -j4 oldconfig


.PHONY: menuconfig
menuconfig:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} -j4 menuconfig


.PHONY: build
build:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} -j4


.PHONY: zImage
zImage:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} -j4 zImage


.PHONY: modules
modules:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} -j4 modules


.PHONY: dtbs
dtbs:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} -j4 dtbs


.PHONY: clean
clean:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} -j4 clean


.PHONY: distclean
distclean:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} -j4 distclean


.PHONY: install
install: install-kernel install-modules


.PHONY: install-modules
install-modules:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} INSTALL_MOD_PATH=$(ROOT) modules_install
