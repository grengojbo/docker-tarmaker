# Golang base host
#
# VERSION               0.1.4

# Golang base host
#
# VERSION               0.1.4

FROM       grengojbo/tarmaker:latest
MAINTAINER Oleg Dolya "oleg.dolya@gmail.com"

#ENV             DEBIAN_FRONTEND noninteractive

#RUN RUN             apt-get -q update && apt-get -qyV install \
#                    --no-install-recommends && apt-get -y autoremove && apt-get -y autoclean && apt-get -y clean

#RUN             env --unset=DEBIAN_FRONTEND

# prepare go environment
ENV GOROOT /usr/local/go
RUN mkdir -p $GOROOT
ENV GOPATH /go
RUN mkdir -p $GOPATH
RUN mkdir -p $GOPATH/src
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

WORKDIR $GOPATH/src
RUN go get github.com/kr/godep
ENV PORT 8080
RUN mkdir -p /app/bin
#ENV HOME /app
#RUN echo 'export GOPATH=/go' >> /app/.bash_profile
#RUN echo 'export PATH=$PATH:$GOPATH/bin'  >> $HOME/.bash_profile