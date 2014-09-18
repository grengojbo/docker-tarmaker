NAME=lsyncd
TAG_IMG=latest
IMAGE_NAME = grengojbo/${NAME}

.PHONY: all run clean push create shell build destroy make_trans syncdb compile_trans static

all: push

push:
	sudo docker push

shell:
	sudo docker run --rm -v /storage:/storage --name ${NAME} -i -t ${IMAGE_NAME} /bin/bash

run:
	sudo docker run --rm -v /storage/tarmaker-${NAME}:/storage/tarmaker-${NAME} --name tarmaker-${NAME} -i -t tarmaker:${NAME} /bin/bash

clean:
	#docker rmi ${IMAGE_NAME}
	deis apps:destroy --app=${NAME} --confirm=${NAME}

create:
	@sudo docker build -t tarmaker:${NAME} tarmaker
	@sudo docker build -t ${IMAGE_NAME} .
	@echo Run conteiners >  make shell
	@sudo docker images | grep grengojbo/asssua | awk '{print $7}'
	@echo ---------------------------------
	@echo image: ${IMAGE_NAME} size:  MB

build:
	@sudo docker build -t ${IMAGE_NAME}:${TAG_IMG} .
