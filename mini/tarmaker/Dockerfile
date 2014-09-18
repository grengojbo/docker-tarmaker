# Dockerfile for grengojbo/tarmaker:python using buildroot
FROM            grengojbo/tarmaker:latest
MAINTAINER      Oleg Dolya "oleg.dolya@gmail.com"

# Install packages
#ENV             DEBIAN_FRONTEND noninteractive

#RUN RUN             apt-get -q update && apt-get -qyV install \
#                    --no-install-recommends && apt-get -y autoremove && apt-get -y autoclean && apt-get -y clean

#RUN             env --unset=DEBIAN_FRONTEND

WORKDIR         /tmp/builder/buildroot


# Add config
ADD             buildroot-config /tmp/builder/buildroot/.config
#ADD             package/bash /tmp/builder/buildroot/package/bash

# Reformat config and prep for make            
RUN             make oldconfig

RUN             echo BR2_PACKAGE_BASH=y >>.config
RUN             echo BR2_PACKAGE_AUTOSSH=y >>.config
RUN             echo BR2_PACKAGE_OPENSSH=y >>.config

# Make
RUN             make --quiet

# Done!
RUN             cp /tmp/builder/buildroot/output/images/rootfs.tar /tmp/rootfs.tar


# Remove duplicate binaries, perl, and python scripts in git-suite and other
# uneeded git files to bring down the image size. Reasoning and method
# described here:
# https://github.com/radial/core-busyboxplus/issues/2#issuecomment-42120299
RUN             mkdir /tmp/rootfs &&\
                tar -C /tmp/rootfs -pxf /tmp/rootfs.tar
WORKDIR         /tmp/rootfs

RUN mkdir -p /tmp/rootfs/usr/local/lib
RUN mkdir -p /tmp/rootfs/usr/local/bin

RUN find /tmp/rootfs -name "*.a" -exec rm '{}' ';'


WORKDIR         /tmp/rootfs
RUN             tar -pcf ../rootfs.tar .

# Done!
WORKDIR         /tmp
RUN             md5sum rootfs.tar > rootfs.tar.md5

