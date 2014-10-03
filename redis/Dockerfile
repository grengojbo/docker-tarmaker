FROM            grengojbo/mini:latest
MAINTAINER      MAINTAINER Oleg Dolya "oleg.dolya@gmail.com"

RUN mkdir -p /app/bin
RUN mkdir -p /data
RUN mkdir -p /run/redis

EXPOSE 6379
VOLUME ["/data"]

WORKDIR /app

ADD redis-cli /app/bin/redis-cli
ADD redis-server /app/bin/redis-server
ADD redis-check-aof /app/bin/redis-check-aof
ADD redis-check-dump /app/bin/redis-check-dump

# set timezone /usr/share/zoneinfo/Europe/Kiev
#ADD localtime  /etc/localtime
#ADD timezone /etc/timezone
#ENV TZ Europe/Kiev
#ENV TZ EEST

# Can't `git pull` unless we set these
# RUN             git config --global user.email "oleg.dolya@gmail.com" && git config --global user.name "grengojbo"
ADD run /app/bin/run
ADD redis.conf /etc/redis/redis.conf

CMD ["/app/bin/run"]
