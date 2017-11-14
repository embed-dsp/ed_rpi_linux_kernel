
# Copyright (c) 2017 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

# This makefile is used to cross compile kernels for the following raspberry pi models:
# * Pi 2
# * Pi 3
# * CM3

KERNEL = kernel7
DEFCONFIG = bcm2709_defconfig

include pi-common.mk
