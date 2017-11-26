
# Copyright (c) 2017 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

# This makefile is used to cross compile kernels for the following raspberry pi models:
#   Raspberry Pi Zero
#   Raspberry Pi Zero Wireless
#   Raspberry Pi 1
#   Compute Module

KCFLAGS = "-march=armv7-a -mtune=cortex-a7"

KERNEL = kernel
DEFCONFIG = bcmrpi_defconfig

include pi-common.mk
