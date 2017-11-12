
# Build Linux Kernel for Raspberry Pi

## Pi 1, Pi 0, Pi 0 W, or CM
```bash
sudo make -f pi.mk clean
sudo make -f pi.mk config
sudo make -f pi.mk build
sudo make -f pi.mk install
```

## Pi 2, Pi 3, or CM3
```bash
sudo make -f pi7.mk clean
sudo make -f pi7.mk config
sudo make -f pi7.mk build
sudo make -f pi7.mk install
```
