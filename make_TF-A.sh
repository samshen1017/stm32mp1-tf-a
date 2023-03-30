#!/bin/bash

TF_A_DIR=$PWD/tf-a-stm32mp-v2.6-stm32mp-r2
ENV_SET=/home/isaac/toolchain/st/stm32mp1/4.0.4-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23/environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi

# 更换需要编译的目标板
# TARGET_NAME=stm32mp157c-astro
TARGET_NAME=stm32mp157d-openedv

cd $TF_A_DIR

#设置编译器
source $ENV_SET

if [ $1 == "debug" ]; then
    unset -v CFLAGS LDFLAGS
    make CROSS_COMPILE=arm-ostl-linux-gnueabi- PLAT=stm32mp1 ARCH=aarch32 ARM_ARCH_MAJOR=7 DTB_FILE_NAME=$TARGET_NAME.dtb STM32MP_SDMMC=1 STM32MP_EMMC=1 DEBUG=1
    
elif [ $1 == "bl32" ]; then
    unset -v CFLAGS LDFLAGS
    make CROSS_COMPILE=arm-ostl-linux-gnueabi- PLAT=stm32mp1 ARCH=aarch32 ARM_ARCH_MAJOR=7 AARCH32_SP=sp_min DTB_FILE_NAME=$TARGET_NAME.dtb DEBUG=1 bl32 dtbs

elif [ $1 == "copy" ]; then
    mkdir -p ../../image
    cp ./build/stm32mp1/debug/tf-a-$TARGET_NAME.stm32 ../../image/
    cp ./build/stm32mp1/debug/bl32.bin ../../image/
    cp ./build/stm32mp1/debug/fdts/$TARGET_NAME-fw-config.dtb ../../image/
    cp ./build/stm32mp1/debug/fdts/$TARGET_NAME-bl32.dtb ../../image/

elif [ $1 == "clean" ]; then
    make distclean
    rm -rf build
fi
