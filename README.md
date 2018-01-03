
Cross Compile of Linux Kernel for Raspberry Pi
==============================================
This repository contains make files and scripts for easy cross compiling of the Linux kernel for Raspberry Pi.

Get the tools
=============

## ed_rpi_linux
```bash
git clone https://github.com/embed-dsp/ed_rpi_linux.git
```

## Rasperry Pi Linux source
Clone the Rasperry Pi Linux source tree into the `ed_rpi_linux` directory.

```bash
# Enter the ed_rpi_linux directory
cd ed_rpi_linux

# Clone the Rasperry Pi Linux source tree
git clone https://github.com/raspberrypi/linux.git
```

## Cross Compile using Raspberry Pi tool chain
Perform these steps to install the [Raspberry Pi tool chain](https://github.com/raspberrypi/tools).

```bash
# Create directory for storing the Raspberry Pi tool chain
sudo mkdir -p /opt/raspberry

# Change the owner from root to <your name>
sudo chown <your name>:<your name> /opt/raspberry

# Enter directory for the Raspberry Pi tool chain
cd /opt/raspberry

# Clone Raspberry Pi tool chain
git clone https://github.com/raspberrypi/tools.git
```

## Cross Compile using Linaro tool chain
Perform these steps to install the [Linaro tool chain](https://www.linaro.org/downloads).

```bash
# Create directory for storing the Linaro tool chain
sudo mkdir -p /opt/gcc-arm

# Change the owner from root to <your name>
sudo chown <your name>:<your name> /opt/gcc-arm

# Enter directory for the Linaro tool chain
cd /opt/gcc-arm

# Download Linaro tool chain
wget https://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/armv8l-linux-gnueabihf/gcc-linaro-7.2.1-2017.11-x86_64_armv8l-linux-gnueabihf.tar.xz

# Install the Linaro tool chain
tar Jxf gcc-linaro-7.2.1-2017.11-x86_64_armv8l-linux-gnueabihf.tar.xz
```

Build the Linux kernel
======================

## Select Cross Compiler
```bash
cd ed_rpi_linux

# Edit rpi-common.mk and select the cross compiler
vim rpi-common.mk
```

## Pi0, Pi0W, Pi1 and CM
```bash
sudo make -f rpi.mk clean
sudo make -f rpi.mk defconfig
sudo make -f rpi.mk build

# Install kernel, modules and device tree blobs into build/pi_kernel_<timestamp> folder.
make -f rpi.mk install
```

## Pi2
```bash
sudo make -f rpi2.mk clean
sudo make -f rpi2.mk defconfig
sudo make -f rpi2.mk build

# Install kernel, modules and device tree blobs into build/pi2_kernel_<timestamp> folder.
make -f rpi2.mk install
```

## Pi3 and CM3
```bash
sudo make -f rpi3.mk clean
sudo make -f rpi3.mk defconfig
sudo make -f rpi3.mk build

# Install kernel, modules and device tree blobs into build/pi3_kernel_<timestamp> folder.
make -f rpi3.mk install
```

# Install built kernel on Rasperry Pi
Use `rsync` and LAN / WiFi to transfer the built kernel to the `/home/pi` directory on Raspberry Pi.

```bash
# Pi0, Pi0W, Pi1 and CM
rsync -avz build/rpi_kernel_<timestamp> pi@<ip address>:/home/pi/

# Pi2
rsync -avz build/rpi2_kernel_<timestamp> pi@<ip address>:/home/pi/

# Pi3 and CM3
rsync -avz build/rpi3_kernel_<timestamp> pi@<ip address>:/home/pi/
```

Use `ssh` to login to Raspberry Pi.

```bash
ssh pi@<ip address>
```

Use the `install.sh` script to backup the current kernel into the `/root` directory and to install the new kernel.

```bash
# Pi0, Pi0W, Pi1 and CM
cd rpi_kernel_<timestamp>
sudo ./install.sh

# Pi2
cd rpi2_kernel_<timestamp>
sudo ./install.sh

# Pi3 and CM3
cd rpi3_kernel_<timestamp>
sudo ./install.sh
```

Reboot the Raspberry Pi.

```bash
sudo reboot
```