
# Copyright (c) 2017-2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

# This makefile is used to cross compile kernels for the following raspberry pi models:
#   Raspberry Pi 2 Model B

KCFLAGS = "-march=armv7-a -mtune=cortex-a7"

RPI = rpi2
KERNEL = kernel7
DEFCONFIG = bcm2709_defconfig

include rpi-common.mk
