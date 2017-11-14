
# Cross Compile Linux Kernel for Raspberry Pi
FIXME:

# How to Get
FIXME:
```bash
git clone https://github.com/embed-dsp/ed_pi_linux.git
```

FIXME:
```bash
git submodule add https://github.com/raspberrypi/linux.git
```

# How to Build

## Cross Compiler
```bash
sudo mkdir -p /opt/raspberry

cd /opt/raspberry

git clone https://github.com/raspberrypi/tools.git
```

## Pi 1, Pi 0, Pi 0 W, or CM
```bash
sudo make -f pi.mk clean
sudo make -f pi.mk defconfig
sudo make -f pi.mk build
sudo make -f pi.mk install
```

## Pi 2, Pi 3, or CM3
```bash
sudo make -f pi7.mk clean
sudo make -f pi7.mk defconfig
sudo make -f pi7.mk build
sudo make -f pi7.mk install
```

# How to Install
FIXME:
