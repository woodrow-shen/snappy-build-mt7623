CPUS := $(shell getconf _NPROCESSORS_ONLN)

OUTPUT_DIR := $(PWD)

LINUX_REPO := lp:~fukuoka-team/fukuoka/+git/kernel
LINUX_BRANCH := master
LINUX_SRC := $(PWD)/kernel
LINUX_UIMAGE := $(PWD)/uImage
LINUX_MODULES := $(PWD)/kernel
#LINUX_DTB := $(LINUX_SRC)/arch/arm/boot/dts/.dtb

UBOOT_REPO := lp:~fukuoka-team/fukuoka/+git/uboot-mtk
UBOOT_BRANCH := demo
UBOOT_SRC := $(PWD)/u-boot-mtk
UBOOT_BIN := $(UBOOT_SRC)/u-boot.bin
