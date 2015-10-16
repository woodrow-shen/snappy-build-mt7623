include common.mk
include device.mk

SNAPPY_IMAGE := mediatek-15.04-snappy.img
# yes for latest version; no for the specific revision of edge/stable channel
SNAPPY_CORE_NEW := no
SNAPPY_CORE_VER := 185
SNAPPY_CORE_CH := edge
OEM_SNAP := mt7623_0.12_all.snap
REVISION ?=

all: build

clean:
		if test -f "$(OUTPUT_DIR)/$(SNAPPY_IMAGE)" ; then rm -r $(OUTPUT_DIR)/$(SNAPPY_IMAGE) ; fi
		if test -f "$(OUTPUT_DIR)/$(SNAPPY_IMAGE).xz" ; then rm -r $(OUTPUT_DIR)/$(SNAPPY_IMAGE).xz ; fi
distclean: clean

build-snappy:
ifeq ($(SNAPPY_CORE_NEW),no)
		$(eval REVISION = --revision $(SNAPPY_CORE_VER))
endif
		@echo "build snappy..."
		sudo ubuntu-device-flash core 15.04 -v \
			--install webdm \
			--oem $(OEM_SNAP) \
			--developer-mode \
			--enable-ssh \
			--device-part=$(DEVICE_TAR) \
			--channel $(SNAPPY_CORE_CH) \
			-o $(SNAPPY_IMAGE) \
			$(REVISION)

fix-bootflag:
		dd conv=notrunc if=boot_fix.bin of=$(SNAPPY_IMAGE) seek=440 oflag=seek_bytes	

workaround:
		./snappy-workaround.sh

pack:
		xz -0 $(SNAPPY_IMAGE)

build: build-snappy fix-bootflag workaround pack 

.PHONY: build-snappy fix-bootflag workaround pack build
