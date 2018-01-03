
# Copyright (c) 2017-2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

# This makefile is used to cross compile kernels for the following raspberry pi models:
#   Raspberry Pi Zero
#   Raspberry Pi Zero Wireless
#   Raspberry Pi 1
#   Compute Module

KCFLAGS = "-march=armv6zk -mtune=arm1176jzf-s"

RPI = rpi
KERNEL = kernel
DEFCONFIG = bcmrpi_defconfig

include rpi-common.mk
