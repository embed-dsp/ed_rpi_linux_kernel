
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
Perform these steps to install the [Linaro tool chain](https://releases.linaro.org/components/toolchain/binaries/latest/armv8l-linux-gnueabihf).

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

# Edit Makefile and select the cross compiler
vim Makefile
```

## RPi0, RPi0W, RPi1 and CM
```bash
sudo make RPI=rpi clean
sudo make RPI=rpi defconfig
sudo make RPI=rpi build

# Install kernel, modules and device tree blobs into build/rpi_kernel_<timestamp> folder.
make RPI=rpi install
```

## RPi2
```bash
sudo make RPI=rpi2 clean
sudo make RPI=rpi2 defconfig
sudo make RPI=rpi2 build

# Install kernel, modules and device tree blobs into build/rpi2_kernel_<timestamp> folder.
make RPI=rpi2 install
```

## RPi3 and CM3
```bash
sudo make RPI=rpi3 clean
sudo make RPI=rpi3 defconfig
sudo make RPI=rpi3 build

# Install kernel, modules and device tree blobs into build/rpi3_kernel_<timestamp> folder.
make RPI=rpi3 install
```

# Install built kernel on Rasperry Pi
Use `rsync` and LAN / WiFi to transfer the built kernel to the `/home/pi` directory on Raspberry Pi.

```bash
# RPi0, RPi0W, RPi1 and CM
rsync -avz build/rpi_kernel_<timestamp> pi@<ip address>:/home/pi/

# RPi2
rsync -avz build/rpi2_kernel_<timestamp> pi@<ip address>:/home/pi/

# RPi3 and CM3
rsync -avz build/rpi3_kernel_<timestamp> pi@<ip address>:/home/pi/
```

Use `ssh` to login to Raspberry Pi.

```bash
ssh pi@<ip address>
```

Use the `install.sh` script to backup the current kernel into the `/root` directory and to install the new kernel.

```bash
# RPi0, RPi0W, RPi1 and CM
cd rpi_kernel_<timestamp>
sudo ./install.sh

# RPi2
cd rpi2_kernel_<timestamp>
sudo ./install.sh

# RPi3 and CM3
cd rpi3_kernel_<timestamp>
sudo ./install.sh
```

Reboot the Raspberry Pi.

```bash
sudo reboot
```