FROM debian:stable

# - Minimal requirements to build a Linux kernel
#     https://docs.kernel.org/process/changes.html#current-minimal-requirements
# - TuxML dependencies
#     https://github.com/TuxML/tuxml

RUN apt-get update -y && apt-get install -y \
    gcc gcc-10-plugin-dev g++ make binutils flex bison dwarves util-linux kmod \
    e2fsprogs jfsutils u-boot-tools reiserfsprogs xfsprogs squashfs-tools \
    btrfs-progs pcmciautils quota rsync xz-utils ppp libnfs-utils procps udev \
    grub grub-common iptables tar openssl libelf-dev lzop libssl-dev \
    bsdmainutils ccache bc sphinx-common sphinx-doc cpio lz4 liblz4-tool \
    pkg-config zstd git curl time python3 libc6-dev-i386 libc6-i386

WORKDIR /srv/local/grandria

CMD \
    if [ ! -d linux-5.13.tar.gz ] ; then \
    curl -O https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.13.tar.gz \
    fi

CMD \
    if [ ! -d linux-5.13 ] ; then \
    tar -xf linux-5.13.tar.gz \
    fi

CMD \
    git clone https://github.com/garandria/LBwCcache.git; \
    git checkout test


# CMD tar -xf linux-5.13.tar.gz ; cd linux-5.13 ; echo "CONFIG_64BIT=y" > config-base ; \
#     KCONFIG_ALLCONFIG=config-base make randconfig ; make -j96
