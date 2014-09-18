#

include includes.mk

.PHONY: all run clean push create shell build destroy

define build_tarmaker
	@sudo docker build -t tarmaker:${NAME} tarmaker
	@sudo docker run --name builder-${NAME} tarmaker:${NAME}
	@sudo docker cp builder-${NAME}:/tmp/rootfs.tar ./
	@sudo docker cp builder-${NAME}:/tmp/rootfs.tar.md5 ./
	@sudo chown 1000:1000 rootfs*
	@sudo docker rm -f builder-${NAME}
endef

check-rootfs:
ifeq (,$(wildcard ./rootfs.tar))
	$(call build_tarmaker)
endif
	@echo "File: rootfs.tar is exist!"

all: check-rootfs

push:
	sudo docker push

shell:
	sudo docker run --rm -v /storage:/storage --name ${NAME} -i -t ${IMAGE_NAME} /bin/bash

run:
	sudo docker run --rm -v /storage/tarmaker-${NAME}:/storage/tarmaker-${NAME} --name tarmaker-${NAME} -i -t tarmaker:${NAME} /bin/bash

clean:
	#sudo docker rmi ${IMAGE_NAME}:${TAG_IMG}

create:
	@sudo docker build -t tarmaker:${NAME} tarmaker
	@sudo docker build -t ${IMAGE_NAME} .
	@echo Run conteiners >  make shell
	@sudo docker images | grep grengojbo/asssua | awk '{print $7}'
	@echo ---------------------------------
	@echo image: ${IMAGE_NAME} size:  MB

build: check-rootfs
	@echo run build: sudo docker build -t ${IMAGE_NAME}:${TAG_IMG} .
