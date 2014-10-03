#

include includes.mk
include ../includes.mk

.PHONY: all run clean push create shell build destroy cli

all: check-rootfs
	make build

push:
	sudo docker push ${IMAGE_NAME}:${TAG_IMG}

shell:
	sudo docker run --rm --name some-redis -it -p 6379:6379 ${IMAGE_NAME}:${TAG_IMG} /bin/bash

run:
	sudo docker run --name some-redis -d -p 6379:6379 ${IMAGE_NAME}:${TAG_IMG} 

cli:
	sudo docker run --rm --name client-redis -it ${IMAGE_NAME}:${TAG_IMG} sh -c 'exec /app/bin/redis-cli -h "127.0.0.1" -p "6380"' 

clean:
	@sudo docker rmi tarmaker:${NAME}
	@sudo docker rmi ${IMAGE_NAME}:${TAG_IMG}
	# rm rootfs.tar
	# rm rootfs.tar.md5

create:
	$(call build_tarmaker)
	
build:
	#test -s ./redis-dist.tar.gz || wget 
	@test ! -s ./redis-dist.tar.gz || tar -xzf ./redis-dist.tar.gz
	@sudo docker build -t ${IMAGE_NAME}:${TAG_IMG} .
	@test ! -s ./redis-server || rm ./redis-s*
	@test ! -s ./redis-cli || rm ./redis-c*
	@echo ---------------------------------
	@echo image: ${IMAGE_NAME}:${TAG_IMG} size: $(shell sudo docker images | grep $(IMAGE_NAME) | grep $(TAG_IMG) | awk '{print $$7 $$8}')
