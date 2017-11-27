
Cross Compile of Linux Kernel for Raspberry Pi
==============================================
This repository contains make files and scripts for cross compiling the Linux kernel for Raspberry Pi.

Get the tools
====================

## ed_pi_linux
```bash
git clone https://github.com/embed-dsp/ed_pi_linux.git
```

## Rasperry Pi Linux source
Clone the Rasperry Pi Linux source tree into the `ed_pi_linux` directory.

```bash
cd ed_pi_linux
git clone https://github.com/raspberrypi/linux.git
```

## Cross Compile using Raspberry Pi tool chain
Perform these steps to install the Raspberry Pi tool chain.

```bash
# Create directory for storing the Raspberry Pi tool chain
sudo mkdir -p /opt/raspberry

# Change the owner from root to <your name>
sudo chown <your name>:<your name> /opt/raspberry

# Enter directory for the Raspberry Pi tool chain and clone
cd /opt/raspberry
git clone https://github.com/raspberrypi/tools.git
```

## Cross Compile using Linaro tool chain
Perform these steps to install the Linaro tool chain.

```bash
# Create directory for storing the Linaro tool chain
sudo mkdir -p /opt/gcc-arm

# Change the owner from root to <your name>
sudo chown <your name>:<your name> /opt/gcc-arm

# Enter directory for the Linaro tool chain
cd /opt/gcc-arm

# Download Linaro tool chain
wget https://releases.linaro.org/components/toolchain/binaries/7.1-2017.08/armv8l-linux-gnueabihf/gcc-linaro-7.1.1-2017.08-x86_64_armv8l-linux-gnueabihf.tar.xz

# Install the Linaro tool chain
tar Jxf gcc-linaro-7.1.1-2017.08-x86_64_armv8l-linux-gnueabihf.tar.xz
```

Build the Linux kernel
======================

## Select Cross Compiler
```bash
cd ed_pi_linux

# Edit pi-common.mk and select the cross compiler
vim pi-common.mk
```

## Pi 0, Pi 0 W, Pi 1 and CM
```bash
sudo make -f pi.mk clean
sudo make -f pi.mk defconfig
sudo make -f pi.mk build
sudo make -f pi.mk install
```

## Pi 2
```bash
sudo make -f pi2.mk clean
sudo make -f pi2.mk defconfig
sudo make -f pi2.mk build
sudo make -f pi2.mk install
```

## Pi 3 and CM3
```bash
sudo make -f pi3.mk clean
sudo make -f pi3.mk defconfig
sudo make -f pi3.mk build
sudo make -f pi3.mk install
```

# Install built kernel on Rasperry Pi
FIXME:
