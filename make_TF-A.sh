#!/bin/bash

TF_A_DIR=$PWD/tf-a-stm32mp-v2.6-stm32mp-r2
ENV_SET=/home/isaac/toolchain/st/stm32mp1/4.0.4-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23/environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi

cd $TF_A_DIR

#设置编译器
source $ENV_SET

#设置FIP目录
export FIP_DEPLOYDIR_ROOT=$PWD/../FIP_artifacts

if [ $1 == "all" ]; then
    #编译所有目标板
    make -f $PWD/../Makefile.sdk DEPLOYDIR=$FIP_DEPLOYDIR_ROOT/arm-trusted-firmware -j12 all

elif [ $1 == "astor" ]; then
    #编译定制板
    make -f $PWD/../Makefile.sdk DEPLOYDIR=$FIP_DEPLOYDIR_ROOT/arm-trusted-firmware TF_A_DEVICETREE=stm32mp157c-astro -j12 all

elif [ $1 == "clean" ]; then
    make -f $PWD/../Makefile.sdk clean
fi

