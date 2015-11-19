include common.mk

V := 0

all: build

clean:
		if test -d "$(LINUX_SRC)" ; then $(MAKE) ARCH=arm CROSS_COMPILE=$(CC) -C $(LINUX_SRC) mrproper ; fi
		rm -f $(LINUX_UIMAGE)

distclean: clean
		rm -rf $(wildcard $(LINUX_SRC))

$(LINUX_SRC):
		git clone $(LINUX_REPO) -b $(LINUX_BRANCH) kernel

$(LINUX_SRC)/.config: $(LINUX_SRC)
		$(MAKE) ARCH=arm CROSS_COMPILE=$(CC) -C $(LINUX_SRC) snappy-fargreat_defconfig
		$(MAKE) ARCH=arm CROSS_COMPILE=$(CC) -C $(LINUX_SRC) prepare
		if test -f $(LINUX_SRC)/include/uapi/linux/autoconf.h ; then rm $(LINUX_SRC)/include/uapi/linux/autoconf.h ; fi
		if test -f $(LINUX_SRC)/include/linux/autoconf.h ; then rm $(LINUX_SRC)/include/linux/autoconf.h ; fi
		ln -s $(LINUX_SRC)/include/generated/autoconf.h $(LINUX_SRC)/include/uapi/linux/autoconf.h
		ln -s $(LINUX_SRC)/include/generated/autoconf.h $(LINUX_SRC)/include/linux/autoconf.h

$(LINUX_UIMAGE): $(LINUX_SRC)/.config
		echo "building kernel and make image"
		rm -f $(LINUX_SRC)/arch/arm/boot/zImage
		rm -f $(LINUX_UIMAGE)
		$(MAKE) ARCH=arm CROSS_COMPILE=$(CC) -C $(LINUX_SRC) -j$(CPUS) V=$(V)

kernel: $(LINUX_UIMAGE)
		mkimage -A arm -O linux -T kernel -C none -a 80008000 -e 80008000 -n "Linux Kernel Image" -d  $(LINUX_SRC)/arch/arm/boot/zImage uImage

modules: $(LINUX_SRC)/.config
		$(MAKE) ARCH=arm CROSS_COMPILE=$(CC) -C $(LINUX_SRC) -j$(CPUS) modules

build: kernel

.PHONY: kernel modules build
