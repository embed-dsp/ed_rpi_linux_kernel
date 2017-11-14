
# Copyright (c) 2017 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

# This makefile is used to cross compile kernels for the following raspberry pi models:
# * Pi 0
# * Pi 0 W
# * Pi 1
# * CM

KERNEL = kernel
DEFCONFIG = bcmrpi_defconfig

include pi-common.mk
