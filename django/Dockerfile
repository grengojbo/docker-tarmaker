FROM            scratch
MAINTAINER      MAINTAINER Oleg Dolya "oleg.dolya@gmail.com"

ADD             rootfs.tar /

ENV PATH /usr/local/bin:$PATH
ENV C_INCLUDE_PATH /usr/include
ENV CPLUS_INCLUDE_PATH /usr/include
ENV LIBRARY_PATH /usr/lib/mysql:/usr/local/lib/python2.7:/usr/lib/python2.7
ENV LD_LIBRARY_PATH /usr/lib/mysql:/usr/local/lib/python2.7:/usr/lib/python2.7

# set timezone /usr/share/zoneinfo/Europe/Kiev
ADD localtime  /etc/localtime
ADD timezone /etc/timezone
#ENV TZ Europe/Kiev
#ENV TZ EEST
ADD ceph/bin  /bin
ADD ceph/etc  /etc
ADD ceph/sbin  /sbin
ADD ceph/usr  /usr
ADD ceph/lib  /lib
ADD ceph/var  /var

# Can't `git pull` unless we set these
# RUN             git config --global user.email "oleg.dolya@gmail.com" && git config --global user.name "grengojbo"

CMD             ["/bin/bash"]

