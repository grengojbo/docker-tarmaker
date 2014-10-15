ifndef NAME
  NAME = ceph
endif

ifndef TAG_IMG
  TAG_IMG = alpha
endif

ifndef IMAGE_REPO
  IMAGE_REPO = grengojbo
endif

ifndef IMAGE_NAME
  IMAGE_NAME = $(IMAGE_REPO)/$(NAME)
endif
