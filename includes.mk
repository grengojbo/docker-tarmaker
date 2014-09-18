ifndef NAME
	NAME = tarmaker
endif

ifndef TAG_IMG
	TAG_IMG = latest
endif

ifndef IMAGE_NAME
	IMAGE_NAME = grengojbo/$(NAME)
endif

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
