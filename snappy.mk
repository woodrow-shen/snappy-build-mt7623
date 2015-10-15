include common.mk

SNAPPY_IMAGE := mediatek-15.04-snappy.img
SNAPPY_CORE_VER := 185
SNAPPY_CORE_CH := edge

all: build

clean:
		rm -r $(OUTPUT_DIR)/$(SNAPPY_IMAGE)

distclean:
		rm -r $(OUTPUT_DIR)/$(SNAPPY_IMAGE)

build-snappy:
		sudo ubuntu-device-flash core 15.04 -v \
			--install webdm \
			--revision 185 \
			--oem mt7623_0.12_all.snap \
			--developer-mode \
			--enable-ssh \
			--device-part=device-mt7623_0.2.tar.xz \
			--channel edge \
			-o mediatek-15.04-snappy.img
	
fix-bootflag:
		dd conv=notrunc if=boot_fix.bin of=$(SNAPPY_IMAGE) seek=440 oflag=seek_bytes	

workaround:
		./snappy-workaround.sh

pack:
		rm $(SNAPPY_IMAGE).xz 
		xz -0 $(SNAPPY_IMAGE)

build: build-snappy fix-bootflag workaround pack 

.PHONY: build-snappy fix-bootflag workaround pack build
