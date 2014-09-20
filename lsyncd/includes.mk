ifndef NAME
  NAME = lsyncd
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
