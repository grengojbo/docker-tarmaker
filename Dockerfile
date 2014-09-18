# Dockerfile for build other docker images
#
# VERSION               0.1.0

FROM            radial/distro
MAINTAINER      Oleg Dolya "oleg.dolya@gmail.com"

# Install packages
ENV             DEBIAN_FRONTEND noninteractive
RUN             apt-get -q update && apt-get -qyV install \
                    wget \
                    build-essential \
                    libncurses-dev \
                    rsync \
                    unzip \
                    bc \
                    gnupg \
                    asciidoc cmake mc vim htop \
                    libc6-i386 curl --no-install-recommends

# For Python
RUN apt-get install -y \
        autoconf \
        build-essential \
        imagemagick \
        libbz2-dev \
        libcurl4-openssl-dev \
        libevent-dev \
        libffi-dev \
        libglib2.0-dev \
        libjpeg-dev \
        libmagickcore-dev \
        libmagickwand-dev \
        libmysqlclient-dev \
        libncurses-dev \
        libpq-dev \
        libpq-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        libxslt-dev \
        zlib1g-dev \
        bzr \
        cvs \
        git \
        mercurial \
        python \
        subversion bison ssh psmisc procps \
        python python-cjson python-dev python-lxml gdal-bin libevent-dev libfreetype6 \
        libfreetype6-dev libgeos-dev libjpeg8 libplist-utils libproj-dev libtiff4-dev \
        libjpeg8-dev liblcms1-dev libwebp-dev python-setuptools python-mako python-gevent python-mysqldb \
        --no-install-recommends

# For lua
RUN apt-get install -y --no-install-recommends \
        lua5.2 liblua5.2-dev
        
#RUN apt-get -y autoremove && apt-get -y autoclean && apt-get -y clean

RUN             env --unset=DEBIAN_FRONTEND

# Create directories
RUN             mkdir -p /tmp/builder
WORKDIR         /tmp/builder

# Retrieve files and check authenticity
ENV             BR_VERSION 2014.08
RUN             wget -nv http://buildroot.uclibc.org/downloads/buildroot-$BR_VERSION.tar.gz &&\
                wget -nv http://buildroot.uclibc.org/downloads/buildroot-$BR_VERSION.tar.gz.sign &&\
                wget -nv http://uclibc.org/~jacmet/pubkey.gpg &&\
                gpg --import pubkey.gpg &&\
                gpg --verify buildroot-$BR_VERSION.tar.gz.sign

# Extract
RUN             tar -zxf buildroot-$BR_VERSION.tar.gz &&\
                mv buildroot-$BR_VERSION buildroot
WORKDIR         /tmp/builder/buildroot

RUN ln -s /usr/lib/x86_64-linux-gnu/libz.so /usr/lib/
RUN ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib/
RUN ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so /usr/lib/


# Create directories
RUN             mkdir -p /tmp/builder
WORKDIR         /tmp/builder

# Retrieve files and check authenticity
ENV             BR_VERSION 2014.08
RUN             wget -nv http://buildroot.uclibc.org/downloads/buildroot-$BR_VERSION.tar.gz &&\
                wget -nv http://buildroot.uclibc.org/downloads/buildroot-$BR_VERSION.tar.gz.sign &&\
                wget -nv http://uclibc.org/~jacmet/pubkey.gpg &&\
                gpg --import pubkey.gpg &&\
                gpg --verify buildroot-$BR_VERSION.tar.gz.sign

# Extract
RUN             tar -zxf buildroot-$BR_VERSION.tar.gz &&\
                mv buildroot-$BR_VERSION buildroot
WORKDIR         /tmp/builder/buildroot
