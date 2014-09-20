docker-tarmaker
===============

Source docker image for build other minimal images

Базовый образ с установлеными пакетами и скаченым builroot
```bash
make build
```

Создаем образ django
====================

```bash
cd django
```
если нет архива buildroot (rootfs.tar)
```bash
make create
```
после создания образа buildroot к нему можно подключится
```bash
make run
```
Создаем образ если хотим изменить тег TAG_IMG=<имя тега>
```bash
make build
TAG_IMG=1.5.9 make build
```
Удаляем созданные изображения
```bash
make clean
```