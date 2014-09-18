#!/bin/sh

[ ! -z "$1" ] || {
    echo "./run.sh <image name> [tag name|latest]"
    exit 1
}
[ -z "$1" ] || {
  IMG=$1
}
[ -z "$2" ] || {
  TAG_IMG=$2
}
[ ! -z "$TAG_IMG" ] || {
  TAG_IMG=latest
  echo "Set default tag $TAG_IMG."
}

sudo docker build -t tarmaker:$IMG tarmaker || {
    echo "Something went wrong. Aborting."
    exit 1
}

[ -f tarmaker/rootfs.tar ] && mv tarmaker/rootfs.tar tarmaker/rootfs.tar.old
[ -f tarmaker/rootfs.tar.md5 ] && mv tarmaker/rootfs.tar.md5 tarmaker/rootfs.tar.md5.old

sudo docker run --name builder-$IMG tarmaker:$IMG
sudo docker cp builder-$IMG:/tmp/rootfs.tar ./
sudo docker cp builder-$IMG:/tmp/rootfs.tar.md5 ./
sudo chown 1000:1000 rootfs*

if md5sum --check rootfs.tar.md5; then
    sudo docker rm -f builder-$IMG &&\
    #sudo docker rmi tarmaker:$IMG &&\
    # We must wait until all removal is done before next step
    #sudo docker build -t grengojbo/$IMG:$TAG_IMG .
    echo "sudo docker build -t grengojbo/$IMG:$TAG_IMG ."
    #sudo docker build -t grengojbo/$IMG:test .
else
    echo "Checksum failed. Aborting."
    echo "Note: the tarmaker:$IMG image and builder-$IMG container have not been deleted."
    exit 1
fi
