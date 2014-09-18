#  Minimal Images
#
# VERSION               1.0.0
FROM            scratch
MAINTAINER Oleg Dolya "oleg.dolya@gmail.com"
ADD             rootfs.tar /

# Can't `git pull` unless we set these
RUN             git config --global user.email "oleg.dolya@gmail.com" &&\
                git config --global user.name "grengojbo"

ADD bash-static /bin/bash
# set timezone /usr/share/zoneinfo/Europe/Kiev
ADD localtime  /etc/localtime
ADD timezone /etc/timezone
#ENV TZ Europe/Kiev
#ENV TZ EEST

CMD             ["/bin/bash"]
