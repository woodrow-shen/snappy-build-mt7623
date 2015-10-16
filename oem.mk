include common.mk

OEM_UBOOT_BIN := oem/boot-assets/u-boot.bin
OEM_SNAP := $(OUTPUT_DIR)/*.snap

all: build

clean:
		rm -f $(OEM_UBOOT_BIN)
		rm -f $(OEM_SNAP)
distclean: clean

u-boot:
		@if [ ! -f $(UBOOT_BIN) ] ; then echo "Build u-boot first."; exit 1; fi
			cp -f $(UBOOT_BIN) $(OEM_UBOOT_BIN)

snappy:
		snappy build oem

oem: u-boot snappy

build: oem

.PHONY: u-boot snappy oem build
