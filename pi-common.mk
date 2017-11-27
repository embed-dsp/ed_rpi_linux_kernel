
# Copyright (c) 2017 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


# ----------------------------------------
# Cross Compiler
# ----------------------------------------
# Cross Compile: Raspberry Pi tool chain (Linux): GCC 4.8.3, Default: 32-bit ARMv6 Cortex-A, hard-float, little-endian
#CCPREFIX = /opt/raspberry/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-

# Cross Compile: Raspberry Pi tool chain (Linux): GCC 4.9.3, Default: 32-bit ARMv6 Cortex-A, hard-float, little-endian
#CCPREFIX = /opt/raspberry/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-

# Cross Compile: Linaro tool chain (Linux): GCC 7.1.1, Default: 32-bit ARMv8 Cortex-A, hard-float, little-endian
CCPREFIX = /opt/gcc-arm/gcc-linaro-7.1.1-2017.08-x86_64_armv8l-linux-gnueabihf/bin/armv8l-linux-gnueabihf-

# Cross Compile: Linaro tool chain (Linux): GCC 7.2.1, Default: 32-bit ARMv8 Cortex-A, hard-float, little-endian
# CCPREFIX = /opt/gcc-arm/gcc-linaro-7.2.1-2017.11-x86_64_armv8l-linux-gnueabihf/bin/armv8l-linux-gnueabihf-


# ...
BUILD_DIR = $(shell pwd)/build

# Directory for installing modules
# ROOT = $(BUILD_DIR)/$(KERNEL)-$(shell date +%Y%m%d_%H%M%S)
ROOT = $(BUILD_DIR)/$(KERNEL)_$(shell date +%Y%m%d)

# Directory for installing kernel and device tree blobs
BOOT = $(ROOT)/boot


all:
	@echo ""
	@echo "# Optionaly clean old build artifacts."
	@echo "sudo make clean"
	@echo ""
	@echo "# Create a default configuration."
	@echo "sudo make defconfig"
	@echo ""
	@echo "# Build kernel, modules and device tree blobs."
	@echo "sudo make build"
	@echo ""
	@echo "# Install kernel, modules and device tree blobs into build/ folder."
	@echo "make install"
	@echo ""


# ...
.PHONY: help
help:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} KCFLAGS=${KCFLAGS} help


# New config with default from ARCH supplied defconfig
.PHONY: defconfig
defconfig:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} KCFLAGS=${KCFLAGS} -j4 $(DEFCONFIG)


# Update current config utilising a provided .config as base
.PHONY: oldconfig
oldconfig:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} KCFLAGS=${KCFLAGS} -j4 oldconfig


# Update current config utilising a menu based program
.PHONY: menuconfig
menuconfig:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} KCFLAGS=${KCFLAGS} -j4 menuconfig


# Compressed kernel image (arch/arm/boot/zImage)
.PHONY: zImage
zImage:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} KCFLAGS=${KCFLAGS} -j4 zImage


# Build all modules
.PHONY: modules
modules:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} KCFLAGS=${KCFLAGS} -j4 modules


# Build device tree blobs for enabled boards
.PHONY: dtbs
dtbs:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} KCFLAGS=${KCFLAGS} -j4 dtbs


# Remove most generated files but keep the config and enough build support to build external modules
.PHONY: clean
clean:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} KCFLAGS=${KCFLAGS} -j4 clean


# mrproper + remove editor backup and patch files
.PHONY: distclean
distclean:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} KCFLAGS=${KCFLAGS} -j4 distclean


# Build zImage, modules and dtbs
.PHONY: build
build:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} KCFLAGS=${KCFLAGS} -j4 zImage modules dtbs


# Install modules, kernel and device tree blobs
.PHONY: install
install: modules_install kernel_install
	cp install.sh $(ROOT)


# Install all modules to INSTALL_MOD_PATH (default: /)
.PHONY: modules_install
modules_install:
	make -C linux ARCH=arm CROSS_COMPILE=${CCPREFIX} KCFLAGS=${KCFLAGS} INSTALL_MOD_PATH=$(ROOT) modules_install


# Install kernel and device tree blobs
.PHONY: kernel_install
kernel_install:
	-mkdir -p $(BOOT)/overlays
	
	cp linux/arch/arm/boot/dts/*.dtb $(BOOT)/
	cp linux/arch/arm/boot/dts/overlays/*.dtb* $(BOOT)/overlays/
	cp linux/arch/arm/boot/dts/overlays/README $(BOOT)/overlays/

	cp linux/arch/arm/boot/zImage $(BOOT)/$(KERNEL).img
