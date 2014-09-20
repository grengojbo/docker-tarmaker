#

include ../includes.mk
include includes.mk

.PHONY: all run clean push create shell build destroy

all: check-rootfs
	make build

push:
	sudo docker push ${IMAGE_NAME}:${TAG_IMG}

shell:
	sudo docker run --rm -v /storage:/storage --name ${NAME} -i -t ${IMAGE_NAME}:${TAG_IMG} /bin/bash

run:
	sudo docker run --rm -v /storage:/storage --name tarmaker-${NAME} -i -t tarmaker:${NAME} /bin/bash

clean:
	@sudo docker rmi tarmaker:${NAME}
	@sudo docker rmi ${IMAGE_NAME}:${TAG_IMG}
	# rm rootfs.tar
	# rm rootfs.tar.md5

create:
	$(call build_tarmaker)
	
old:
	@sudo docker build -t tarmaker:${NAME} tarmaker
	@sudo docker build -t ${IMAGE_NAME} .
	@echo Run conteiners >  make shell
	@sudo docker images | grep grengojbo/asssua | awk '{print $7}'
	@echo ---------------------------------
	@echo image: ${IMAGE_NAME} size:  MB

build: check-rootfs
	@echo run build: sudo docker build -t ${IMAGE_NAME}:${TAG_IMG} .
