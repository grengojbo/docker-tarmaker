#

include ../includes.mk
include includes.mk

.PHONY: all run clean push create shell build destroy

all: check-rootfs
	make build

push:
	sudo docker push

shell:
	sudo docker run --rm -v /storage:/storage --name ${NAME} -i -t ${IMAGE_NAME} /bin/bash

run:
	sudo docker run --rm -v /storage/tarmaker-${NAME}:/storage/tarmaker-${NAME} --name tarmaker-${NAME} -i -t tarmaker:${NAME} /bin/bash

clean:
	#sudo docker rmi ${IMAGE_NAME}:${TAG_IMG}

create:
	$(call build_tarmaker)
	
build: check-rootfs
	@echo run build: sudo docker build -t ${IMAGE_NAME}:${TAG_IMG} .
