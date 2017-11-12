
# Copyright (c) 2017 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

export KERNEL = kernel

include pi-common.mk


# Pi 1, Pi 0, Pi 0 W, or CM
.PHONY: config
config:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} -j4 bcmrpi_defconfig


.PHONY: install-kernel
install-kernel:
	# ...
	mv $(BOOT)/kernel.img $(BOOT)/kernel-old.img
	cp arch/arm/boot/zImage $(BOOT)/kernel.img
	# ...
#	rm -rf $(BOOT)/overlays-old
#	mv $(BOOT)/overlays $(BOOT)/overlays-old
#	mkdir $(BOOT)/overlays
#	cp arch/arm/boot/dts/overlays/*.dtb* $(BOOT)/overlays/
