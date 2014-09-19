# Dockerfile for grengojbo/tarmaker:django using buildroot
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

#RUN             sed -i 's/BR2_USE_MMU=y/# BR2_USE_MMU=y/' .config &&\
RUN             echo BR2_PACKAGE_BASH=y >>.config
RUN             echo BR2_PACKAGE_AUTOSSH=y >>.config
RUN             echo BR2_PACKAGE_OPENSSH=y >>.config

# Make
RUN             make --quiet
#RUN             make

# Done!
RUN             cp /tmp/builder/buildroot/output/images/rootfs.tar /tmp/rootfs.tar


# Remove duplicate binaries, perl, and python scripts in git-suite and other
# uneeded git files to bring down the image size. Reasoning and method
# described here:
# https://github.com/radial/core-busyboxplus/issues/2#issuecomment-42120299
RUN             mkdir /tmp/rootfs &&\
                tar -C /tmp/rootfs -pxf /tmp/rootfs.tar
WORKDIR         /tmp/rootfs

RUN easy_install pip
RUN pip install -U distribute
RUN pip install gevent
RUN pip install gunicorn
RUN pip install mysql-python
RUN pip install Pillow
RUN pip install hiredis

RUN mkdir -p /tmp/py && cp /usr/local/bin/*.py /tmp/py/
RUN find /usr/ -name "*.py" -exec rm '{}' ';'
RUN mv /tmp/py/* /usr/local/bin/

ADD             freeze.txt /tmp/req.txt
RUN pip install -r /tmp/req.txt

#RUN mkdir -p /usr/local
#RUN mkdir -p /usr/include
RUN mkdir -p /tmp/rootfs/usr/local/lib
RUN mkdir -p /tmp/rootfs/usr/local/bin
RUN mkdir -p /tmp/rootfs/usr/lib/mysql

#ADD usr  /usr
RUN cp -R /usr/include/python2.7 /tmp/rootfs/usr/include/
RUN cp -R /usr/lib/python2.7  /tmp/rootfs/usr/lib/
RUN cp -R /usr/lib/pymodules  /tmp/rootfs/usr/lib/
RUN cp -R /usr/lib/pyshared  /tmp/rootfs/usr/lib/
RUN cp /usr/bin/python2.7  /tmp/rootfs/usr/bin/
RUN cp /usr/bin/python2.7  /tmp/rootfs/usr/bin/python2
RUN cp /usr/bin/python2.7  /tmp/rootfs/usr/bin/python
RUN cp /usr/bin/python2.7-config  /tmp/rootfs/usr/bin/
RUN cp /usr/bin/python2.7-config  /tmp/rootfs/usr/bin/python2-config
RUN cp /usr/bin/python2.7-config  /tmp/rootfs/usr/bin/python-config

RUN cp -R /usr/local/bin /tmp/rootfs/usr/local/
RUN cp -R /usr/local/lib /tmp/rootfs/usr/local/

RUN rm /tmp/rootfs/usr/lib/libjpeg.*
RUN cp /lib/x86_64-linux-gnu/liblzma* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/liblzma* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libjbig.* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libtiff* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libz.* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libjpeg.* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libfreetype.* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libmysqlclient* /tmp/rootfs/usr/lib/mysql/
RUN find /tmp/rootfs -name "*.a" -exec rm '{}' ';'


WORKDIR         /tmp/rootfs
RUN             tar -pcf ../rootfs.tar .

# Done!
WORKDIR         /tmp
RUN             md5sum rootfs.tar > rootfs.tar.md5

