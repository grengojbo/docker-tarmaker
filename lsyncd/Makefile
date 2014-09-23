#

include includes.mk
include ../includes.mk

.PHONY: all run clean push create shell build destroy

all: check-rootfs
	make build

push:
	sudo docker push ${IMAGE_NAME}:${TAG_IMG}

shell:
	sudo docker run --rm -v /storage:/storage -v /root:/root --name ${NAME} -i -t ${IMAGE_NAME}:${TAG_IMG} /bin/bash

run:
	sudo docker run --rm -v /storage:/storage --name tarmaker-${NAME} -i -t tarmaker:${NAME} /bin/bash

clean:
	@sudo docker rmi tarmaker:${NAME}
	@sudo docker rmi ${IMAGE_NAME}:${TAG_IMG}
	# rm rootfs.tar
	# rm rootfs.tar.md5

create:
	$(call build_tarmaker)
	
build: check-rootfs
	@test -s ./localtime || { cp ../localtime ./ && cp ../timezone ./; }
	@sudo docker build -t ${IMAGE_NAME}:${TAG_IMG} .
	@echo ---------------------------------
	@echo image: ${IMAGE_NAME}:${TAG_IMG} size: $(shell sudo docker images | grep $(IMAGE_NAME) | grep $(TAG_IMG) | awk '{print $$7 $$8}')
	@rm ./localtime
	@rm ./timezone
