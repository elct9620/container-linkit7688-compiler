FROM ubuntu:14.04

ENV OPENWRT /usr/src/openwrt
ENV VERSION 15.05
ENV PATH $OPENWRT/staging_dir/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/bin:$PATH
ENV STAGING_DIR $OPENWRT/staging_dir/

ENV TARGET_CC mipsel-openwrt-linux-uclibc-gcc
ENV TARGET_CXX mipsel-openwrt-linux-uclibc-g++
ENV TARGET_LD mipsel-openwrt-linux-uclibc-gcc
ENV TARGET_AR mipsel-openwrt-linux-uclibc-gcc-ar

RUN apt-get update
RUN apt-get -y install git g++ make libncurses5-dev subversion libssl-dev gawk libxml-parser-perl unzip wget python xz-utils
RUN cd /usr/src && git clone git://git.openwrt.org/$VERSION/openwrt.git

ADD lks7688.config $OPENWRT/.config

RUN cd $OPENWRT && \
    ./scripts/feeds update -a && \
    ./scripts/feeds install -a && \
    make defconfig && \
    make tools/install -j"$(nproc)"  && \
    make toolchain/install -j"$(nproc)"
