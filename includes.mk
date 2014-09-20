define build_tarmaker
	@sudo docker build -t tarmaker:${NAME} tarmaker
	@sudo docker run --name builder-${NAME} tarmaker:${NAME}
	@sudo docker cp builder-${NAME}:/tmp/rootfs.tar ./
	@sudo docker cp builder-${NAME}:/tmp/rootfs.tar.md5 ./
	@sudo chown 1000:1000 rootfs*
	@sudo docker rm -f builder-${NAME}
  @echo ---------------------------------
  @echo image: tarmaker:${NAME} size: $(shell sudo docker images | grep $(IMAGE_NAME) | grep $(TAG_IMG) | awk '{print $$7 $$8}')
endef

check-rootfs:
	@test -s ./rootfs.tar || { echo "rootfs.tar does not exist! Exiting...";  echo "Run: make create"; exit 1; }
