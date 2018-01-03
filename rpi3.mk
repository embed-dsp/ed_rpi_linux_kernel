
# Copyright (c) 2017-2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

# This makefile is used to cross compile kernels for the following raspberry pi models:
#   Raspberry Pi 3 Model B
#   Compute Module 3

KCFLAGS = "-march=armv8-a -mtune=cortex-a53"

RPI = rpi3
KERNEL = kernel7
DEFCONFIG = bcm2709_defconfig

include rpi-common.mk