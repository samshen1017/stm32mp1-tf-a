#!/bin/bash

TF_A_DIR=$PWD/tf-a-stm32mp-v2.6-stm32mp-r2
ENV_SET=/home/isaac/toolchain/st/stm32mp1/4.0.4-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23/environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi

cd $TF_A_DIR

#设置编译器
$ source $ENV_SET

#设置FIP目录
$ export FIP_DEPLOYDIR_ROOT=$PWD/../FIP_artifacts

#编译
$ make -f $PWD/../Makefile.sdk DEPLOYDIR=$FIP_DEPLOYDIR_ROOT/arm-trusted-firmware -j12 all
$ make -f $PWD/../Makefile.sdk -j12 all