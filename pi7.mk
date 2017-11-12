
# Copyright (c) 2017 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

export KERNEL = kernel7

include pi-common.mk


# Pi 2, Pi 3, or CM3
.PHONY: config
config:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} -j4 bcm2709_defconfig


.PHONY: install-kernel
install-kernel:
	# ...
	mv $(BOOT)/kernel7.img $(BOOT)/kernel7-old.img
	cp arch/arm/boot/zImage $(BOOT)/kernel7.img
	# ...
	rm -rf $(BOOT)/overlays-old
	mv $(BOOT)/overlays $(BOOT)/overlays-old
	mkdir $(BOOT)/overlays
	cp arch/arm/boot/dts/overlays/*.dtb* $(BOOT)/overlays/
