FROM debian:bullseye

# - Minimal requirements to build a Linux kernel
#     https://docs.kernel.org/process/changes.html#current-minimal-requirements
# - TuxML dependencies
#     https://github.com/TuxML/tuxml

RUN apt-get update -y && apt-get install -y \
    gcc-10 gcc-10-plugin-dev g++ make binutils flex bison dwarves util-linux kmod \
    e2fsprogs jfsutils u-boot-tools reiserfsprogs xfsprogs squashfs-tools \
    btrfs-progs pcmciautils quota rsync xz-utils ppp libnfs-utils procps udev \
    grub-common iptables tar openssl libelf-dev lzop libssl-dev \
    bsdmainutils ccache bc sphinx-common sphinx-doc cpio lz4 liblz4-tool \
    pkg-config zstd git curl time python3 libc6-dev-i386 libc6-i386

# grub

RUN cd / && curl -O https://raw.githubusercontent.com/garandria/LBwCcache/master/gcc-10-plugin-dev-workaround-980609.patch && patch -p1 < gcc-10-plugin-dev-workaround-980609.patch

WORKDIR /srv/local/grandria

# CMD \
#     if [ ! -d linux-5.13.tar.gz ] ; then \
#     curl -O https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.13.tar.gz ;\
#     fi ; \
#     if [ ! -d linux-5.13 ] ; then \
#     tar -xf linux-5.13.tar.gz ;\
#     fi ; \
#     git clone https://github.com/garandria/LBwCcache.git; \
#     cd LBwCcache ;  git checkout test ; cp -r b1 .. ; cd .. ;\
#     python3 LBwCcache/main.py \
#     --linux-src /srv/local/grandria/linux-5.13 \
#     --configurations /srv/local/grandria/b1
