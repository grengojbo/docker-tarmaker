#
ifndef NAME
	NAME = tarmaker
endif

ifndef TAG_IMG
	TAG_IMG = latest
endif

ifndef IMAGE_REPO
	IMAGE_REPO = grengojbo
endif

ifndef IMAGE_NAME
	IMAGE_NAME = $(IMAGE_REPO)/$(NAME)
endif

include includes.mk

.PHONY: all run clean push create shell build destroy


all: 
	@echo make build
	
shell:
	sudo docker run --rm -v /storage:/storage --name ${NAME} -i -t ${IMAGE_NAME}:${TAG_IMG} /bin/bash

clean:
	$(shell for i in `sudo docker images | grep \<none\> | awk '{print $$3}'`; do sudo docker rmi $$i; done)
	#docker images --no-trunc | grep none | awk '{print $3}' | xargs docker rmi
	#docker ps -a | grep 'weeks ago' | awk '{print $1}' | xargs docker rm
	#docker rm $(docker ps -a | grep Exited | awk '{print $1}')
	
	@sudo docker rmi ${IMAGE_NAME}:${TAG_IMG}

build:
	@sudo docker build -t ${IMAGE_NAME}:${TAG_IMG} . || { echo "Something went wrong. Aborting."; exit 1; }

