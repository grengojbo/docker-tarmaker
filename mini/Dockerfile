FROM            scratch
MAINTAINER      MAINTAINER Oleg Dolya "oleg.dolya@gmail.com"

ADD             rootfs.tar /

#WORKDIR /root

# set timezone /usr/share/zoneinfo/Europe/Kiev
ADD localtime  /etc/localtime
ADD timezone /etc/timezone
#ENV TZ Europe/Kiev
#ENV TZ EEST

# Can't `git pull` unless we set these
# RUN             git config --global user.email "oleg.dolya@gmail.com" && git config --global user.name "grengojbo"

CMD             ["/bin/bash"]
