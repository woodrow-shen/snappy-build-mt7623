# snappy-build-mt7623
Scripts to build [Snappy Ubuntu Core](http://developer.ubuntu.com/snappy/) for Mediatek Mt7623, which includes OEM snap and device part.

## Requirements
To build all parts, a couple of dependencies are required. On Ubuntu you can
install all build dependencies with the following command.

```bash
sudo apt-get install build-essential u-boot-tools lzop debootstrap debootstrap gcc-arm-linux-gnueabihf
```

Then, you need to install snappy tools from PPA, for creating image.

```bash
sudo add-apt-repository -y ppa:snappy-dev/tools
sudo apt-get update
sudo apt-get install ubuntu-device-flash
```

## Quick Build
A `Makefile` is provided to build OEM snap, U-Boot, Kernel and Initrd from source. The sources will be cloned into local folders if not there already.

To build it all, just run `make snappy`. This will produce a oem snap `mt7623_x.y_all.snap` and a `device-mt7623_x.y.tar.gz` device part, which can be used to build your own Snappy image.

### Build U-boot

```bash
make u-boot
```

### Build OEM snap

```bash
make oem
```

### Build device part

```bash
make device
```

## Flash to SD card

```bash
xzcat ${image} | pv | sudo dd of=/dev/${device} bs=32M ; sync
```
