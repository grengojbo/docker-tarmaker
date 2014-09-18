ifneq ("$(wildcard $(PATH_TO_FILE))","")

ifneq ("$(wildcard $(FILE_PATH))","")
	@echo Файл есть  
else
  @echo Файла нет
endif

ifeq (,$(wildcard /opt/local/bin/gsort))
    $(error GNU Sort does not exist!)
endif