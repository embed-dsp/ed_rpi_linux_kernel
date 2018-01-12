
# Copyright (c) 2017-2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


# ----------------------------------------
# Cross Compiler
# ----------------------------------------
# Cross Compile: Raspberry Pi tool chain (Linux): GCC 4.8.3, Default: 32-bit ARMv6 Cortex-A, hard-float, little-endian
#TOOL_CHAIN := /opt/raspberry/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin
#TOOL_TRIPLET := arm-linux-gnueabihf
#TOOL_PREFIX := $(TOOL_TRIPLET)-

# Cross Compile: Raspberry Pi tool chain (Linux): GCC 4.9.3, Default: 32-bit ARMv6 Cortex-A, hard-float, little-endian
TOOL_CHAIN := /opt/raspberry/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin
TOOL_TRIPLET := arm-linux-gnueabihf
TOOL_PREFIX := $(TOOL_TRIPLET)-

# Cross Compile: Linaro tool chain (Linux): GCC 7.1.1, Default: 32-bit ARMv8 Cortex-A, hard-float, little-endian
#TOOL_CHAIN := /opt/gcc-arm/gcc-linaro-7.1.1-2017.08-x86_64_armv8l-linux-gnueabihf/bin
#TOOL_TRIPLET := armv8l-linux-gnueabihf
#TOOL_PREFIX := $(TOOL_TRIPLET)-

# Cross Compile: Linaro tool chain (Linux): GCC 7.2.1, Default: 32-bit ARMv8 Cortex-A, hard-float, little-endian
# TOOL_CHAIN := /opt/gcc-arm/gcc-linaro-7.2.1-2017.11-x86_64_armv8l-linux-gnueabihf/bin
# TOOL_TRIPLET := armv8l-linux-gnueabihf
# TOOL_PREFIX := $(TOOL_TRIPLET)-


CCPREFIX := $(TOOL_CHAIN)/$(TOOL_PREFIX)

# ----------------------------------------
# ...
# ----------------------------------------
ifeq ($(RPI),rpi)
    # Raspberry Pi Zero
    # Raspberry Pi Zero Wireless
    # Raspberry Pi 1
    # Compute Module
    KCFLAGS := "-march=armv6zk -mtune=arm1176jzf-s"
    KERNEL := kernel
    DEFCONFIG := bcmrpi_defconfig
else ifeq ($(RPI),rpi2)
    # Raspberry Pi 2 Model B
    KCFLAGS := "-march=armv7-a -mtune=cortex-a7"
    KERNEL := kernel7
    DEFCONFIG := bcm2709_defconfig
else ifeq ($(RPI),rpi3)
    # Raspberry Pi 3 Model B
    # Compute Module 3
    KCFLAGS := "-march=armv8-a -mtune=cortex-a53"
    KERNEL := kernel7
    DEFCONFIG := bcm2709_defconfig
else
    $(error "Invallid value for RPI variable.")
endif

ifeq ($(J),)
    J := 4
endif


# ...
BUILD_DIR := $(shell pwd)/build

# Directory for installing modules
# ROOT = $(BUILD_DIR)/$(KERNEL)_$(shell date +%Y%m%d)
ROOT := $(BUILD_DIR)/$(RPI)_kernel_$(shell date +%Y%m%d)

# Directory for installing kernel and device tree blobs
BOOT := $(ROOT)/boot


all:
	@echo ""
	@echo "# Optionaly clean old build artifacts."
	@echo "sudo make clean RPI=..."
	@echo ""
	@echo "# Create a default configuration."
	@echo "sudo make defconfig RPI=..."
	@echo ""
	@echo "# Build kernel, modules and device tree blobs."
	@echo "sudo make build RPI=... [J=...]"
	@echo ""
	@echo "# Install kernel, modules and device tree blobs into build/ folder."
	@echo "make install RPI=..."
	@echo ""


# ...
.PHONY: help
help:
	make -C linux ARCH=arm CROSS_COMPILE=$(CCPREFIX) help


# New config with default from ARCH supplied defconfig
.PHONY: defconfig
defconfig:
	make -C linux ARCH=arm CROSS_COMPILE=$(CCPREFIX) $(DEFCONFIG)


# Update current config utilising a provided .config as base
.PHONY: oldconfig
oldconfig:
	make -C linux ARCH=arm CROSS_COMPILE=$(CCPREFIX) oldconfig


# Update current config utilising a menu based program
.PHONY: menuconfig
menuconfig:
	make -C linux ARCH=arm CROSS_COMPILE=$(CCPREFIX) menuconfig


# Compressed kernel image (arch/arm/boot/zImage)
.PHONY: zImage
zImage:
	make -C linux ARCH=arm CROSS_COMPILE=$(CCPREFIX) KCFLAGS=$(KCFLAGS) -j$(J) zImage


# Build all modules
.PHONY: modules
modules:
	make -C linux ARCH=arm CROSS_COMPILE=$(CCPREFIX) KCFLAGS=$(KCFLAGS) -j$(J) modules


# Build device tree blobs for enabled boards
.PHONY: dtbs
dtbs:
	make -C linux ARCH=arm CROSS_COMPILE=$(CCPREFIX) KCFLAGS=$(KCFLAGS) -j$(J) dtbs


# Remove most generated files but keep the config and enough build support to build external modules
.PHONY: clean
clean:
	make -C linux ARCH=arm CROSS_COMPILE=$(CCPREFIX) clean


# mrproper + remove editor backup and patch files
.PHONY: distclean
distclean:
	make -C linux ARCH=arm CROSS_COMPILE=$(CCPREFIX) distclean


# Build zImage, modules and dtbs
.PHONY: build
build:
	make -C linux ARCH=arm CROSS_COMPILE=$(CCPREFIX) KCFLAGS=$(KCFLAGS) -j$(J) zImage modules dtbs


# Install modules, kernel and device tree blobs
.PHONY: install
install: modules_install kernel_install
	cp install.sh $(ROOT)


# Install all modules to INSTALL_MOD_PATH (default: /)
.PHONY: modules_install
modules_install:
	make -C linux ARCH=arm CROSS_COMPILE=$(CCPREFIX) INSTALL_MOD_PATH=$(ROOT) modules_install


# Install kernel and device tree blobs
.PHONY: kernel_install
kernel_install:
	-mkdir -p $(BOOT)/overlays
	
	cp linux/arch/arm/boot/dts/*.dtb $(BOOT)/
	cp linux/arch/arm/boot/dts/overlays/*.dtb* $(BOOT)/overlays/
	cp linux/arch/arm/boot/dts/overlays/README $(BOOT)/overlays/

	cp linux/arch/arm/boot/zImage $(BOOT)/$(KERNEL).img
