FROM            scratch
MAINTAINER      MAINTAINER Oleg Dolya "oleg.dolya@gmail.com"

ADD             rootfs.tar /

RUN mkdir -p /data/test1
RUN mkdir -p /data/test2
WORKDIR /root

#cp /storage/deis /root/.ssh/id_rsa
#cp -R /home/core/.ssh /root/
ADD multi_targets.lua /data/test1/multi_targets.lua
ADD config.lua /usr/local/etc/lsyncd/config.lua
# set timezone /usr/share/zoneinfo/Europe/Kiev
ADD localtime  /etc/localtime
ADD timezone /etc/timezone
#ENV TZ Europe/Kiev
#ENV TZ EEST

# Can't `git pull` unless we set these
# RUN             git config --global user.email "oleg.dolya@gmail.com" && git config --global user.name "grengojbo"
EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd"]
CMD             ["/usr/local/bin/lsyncd", "/root/config.lua"]
# /usr/local/bin/lsyncd /root/config.lua
