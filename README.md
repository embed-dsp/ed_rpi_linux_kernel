
Cross Compile of Linux Kernel for Raspberry Pi
==============================================
This repository contains make files and scripts for easy cross compiling of the Linux kernel for Raspberry Pi.

Get the tools
=============

## ed_pi_linux
```bash
git clone https://github.com/embed-dsp/ed_pi_linux.git
```

## Rasperry Pi Linux source
Clone the Rasperry Pi Linux source tree into the `ed_pi_linux` directory.

```bash
# Enter the ed_pi_linux directory
cd ed_pi_linux

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
cd ed_pi_linux

# Edit pi-common.mk and select the cross compiler
vim pi-common.mk
```

## Pi0, Pi0W, Pi1 and CM
```bash
sudo make -f pi.mk clean
sudo make -f pi.mk defconfig
sudo make -f pi.mk build

# Install kernel, modules and device tree blobs into build/pi_kernel_<timestamp> folder.
make -f pi.mk install
```

## Pi2
```bash
sudo make -f pi2.mk clean
sudo make -f pi2.mk defconfig
sudo make -f pi2.mk build

# Install kernel, modules and device tree blobs into build/pi2_kernel_<timestamp> folder.
make -f pi2.mk install
```

## Pi3 and CM3
```bash
sudo make -f pi3.mk clean
sudo make -f pi3.mk defconfig
sudo make -f pi3.mk build

# Install kernel, modules and device tree blobs into build/pi3_kernel_<timestamp> folder.
make -f pi3.mk install
```

# Install built kernel on Rasperry Pi
Use `rsync` and LAN / WiFi to transfer the built kernel to the `/home/pi` directory on Raspberry Pi.

```bash
# Pi0, Pi0W, Pi1 and CM
rsync -avz build/pi_kernel_<timestamp> pi@<ip address>:/home/pi/

# Pi2
rsync -avz build/pi2_kernel_<timestamp> pi@<ip address>:/home/pi/

# Pi3 and CM3
rsync -avz build/pi3_kernel_<timestamp> pi@<ip address>:/home/pi/
```

Use `ssh` to login to Raspberry Pi.

```bash
ssh pi@<ip address>
```

Use the `install.sh` script to backup the current kernel into the `/root` directory and to install the new kernel.

```bash
# Pi0, Pi0W, Pi1 and CM
cd pi_kernel_<timestamp>
sudo ./install.sh

# Pi2
cd pi2_kernel_<timestamp>
sudo ./install.sh

# Pi3 and CM3
cd pi3_kernel_<timestamp>
sudo ./install.sh
```

Reboot the Raspberry Pi.

```bash
sudo reboot
```