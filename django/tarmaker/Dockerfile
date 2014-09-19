# Dockerfile for grengojbo/tarmaker:django using buildroot
FROM            grengojbo/tarmaker:latest
MAINTAINER      Oleg Dolya "oleg.dolya@gmail.com"

# Install packages
#ENV             DEBIAN_FRONTEND noninteractive

#RUN RUN             apt-get -q update && apt-get -qyV install \
#                    --no-install-recommends && apt-get -y autoremove && apt-get -y autoclean && apt-get -y clean

#RUN             env --unset=DEBIAN_FRONTEND

WORKDIR         /tmp/builder/buildroot


# Add config
ADD             buildroot-config /tmp/builder/buildroot/.config
#ADD             package/bash /tmp/builder/buildroot/package/bash

# Reformat config and prep for make            
RUN             make oldconfig

#RUN             sed -i 's/BR2_USE_MMU=y/# BR2_USE_MMU=y/' .config &&\
RUN             echo BR2_PACKAGE_BASH=y >>.config
RUN             echo BR2_PACKAGE_AUTOSSH=y >>.config
RUN             echo BR2_PACKAGE_OPENSSH=y >>.config

# Make
RUN             make --quiet
#RUN             make

# Done!
RUN             cp /tmp/builder/buildroot/output/images/rootfs.tar /tmp/rootfs.tar


# Remove duplicate binaries, perl, and python scripts in git-suite and other
# uneeded git files to bring down the image size. Reasoning and method
# described here:
# https://github.com/radial/core-busyboxplus/issues/2#issuecomment-42120299
RUN             mkdir /tmp/rootfs &&\
                tar -C /tmp/rootfs -pxf /tmp/rootfs.tar

# rm git 140 mb
WORKDIR         /tmp/rootfs/usr/libexec/git-core
RUN             rm -f \
                    git-add \
                    git-add--interactive \
                    git-annotate \
                    git-apply \
                    git-archimport \
                    git-archive \
                    git-bisect--helper \
                    git-blame \
                    git-branch \
                    git-bundle \
                    git-credential-cache \
                    git-credential-cache--daemon \
                    git-credential-store \
                    git-cat-file \
                    git-check-attr \
                    git-check-ignore \
                    git-check-mailmap \
                    git-check-ref-format \
                    git-checkout \
                    git-checkout-index \
                    git-cherry \
                    git-cherry-pick \
                    git-clean \
                    git-clone \
                    git-column \
                    git-commit \
                    git-commit-tree \
                    git-config \
                    git-count-objects \
                    git-credential \
                    git-cvsexportcommit \
                    git-cvsimport \
                    git-cvsserver \
                    git-daemon \
                    git-describe \
                    git-diff \
                    git-diff-files \
                    git-diff-index \
                    git-diff-tree \
                    git-difftool \
                    git-fast-export \
                    git-fast-import \
                    git-fetch \
                    git-fetch-pack \
                    git-fmt-merge-msg \
                    git-for-each-ref \
                    git-format-patch \
                    git-fsck \
                    git-fsck-objects \
                    git-gc \
                    git-get-tar-commit-id \
                    git-grep \
                    git-hash-object \
                    git-help \
                    git-http-backend\
                    git-imap-send \
                    git-index-pack \
                    git-init \
                    git-init-db \
                    git-log \
                    git-ls-files \
                    git-ls-remote \
                    git-ls-tree \
                    git-mailinfo \
                    git-mailsplit \
                    git-merge \
                    git-merge-base \
                    git-merge-file \
                    git-merge-index \
                    git-merge-ours \
                    git-merge-recursive \
                    git-merge-subtree \
                    git-merge-tree \
                    git-mktag \
                    git-mktree \
                    git-mv \
                    git-name-rev \
                    git-notes \
                    git-p4 \
                    git-pack-objects \
                    git-pack-redundant \
                    git-pack-refs \
                    git-patch-id \
                    git-peek-remote \
                    git-prune \
                    git-prune-packed \
                    git-push \
                    git-read-tree \
                    git-receive-pack \
                    git-reflog \
                    git-relink \
                    git-remote \
                    git-remote-ext \
                    git-remote-fd \
                    git-remote-testsvn \
                    git-repack \
                    git-replace \
                    git-repo-config \
                    git-rerere \
                    git-reset \
                    git-rev-list \
                    git-rev-parse \
                    git-revert \
                    git-rm \
                    git-send-email \
                    git-send-pack \
                    git-shell \
                    git-shortlog \
                    git-show \
                    git-show-branch \
                    git-show-index \
                    git-show-ref \
                    git-stage \
                    git-show-ref \
                    git-stage \
                    git-status \
                    git-stripspace \
                    git-svn \
                    git-symbolic-ref \
                    git-tag \
                    git-tar-tree \
                    git-unpack-file \
                    git-unpack-objects \
                    git-update-index \
                    git-update-ref \
                    git-update-server-info \
                    git-upload-archive \
                    git-var \
                    git-verify-pack \
                    git-verify-tag \
                    git-whatchanged \
                    git-write-tree

WORKDIR         /tmp/rootfs/usr/bin
RUN             rm -f \
                    git \
                    git-cvsserver \
                    git-shell \
                    git-receive-pack \
                    git-upload-pack \
                    git-upload-archive &&\
                ln -s ../libexec/git-core/git git &&\
                ln -s ../libexec/git-core/git-shell git-shell &&\
                ln -s ../libexec/git-core/git git-upload-archive &&\
                ln -s ../libexec/git-core/git-upload-pack git-upload-pack 

WORKDIR         /tmp/rootfs/usr/libexec/git-core
RUN             ln -s git git-merge
# end rm git

WORKDIR         /tmp/rootfs

RUN easy_install pip
RUN pip install -U distribute
RUN pip install gevent
RUN pip install gunicorn
RUN pip install mysql-python
RUN pip install Pillow
RUN pip install hiredis

RUN mkdir -p /tmp/py && cp /usr/local/bin/*.py /tmp/py/
RUN find /usr/ -name "*.py" -exec rm '{}' ';'
RUN mv /tmp/py/* /usr/local/bin/

ADD             freeze.txt /tmp/req.txt
RUN pip install -r /tmp/req.txt

#RUN mkdir -p /usr/local
#RUN mkdir -p /usr/include
RUN mkdir -p /tmp/rootfs/usr/local/lib
RUN mkdir -p /tmp/rootfs/usr/local/bin
RUN mkdir -p /tmp/rootfs/usr/lib/mysql

#ADD usr  /usr
RUN cp -R /usr/include/python2.7 /tmp/rootfs/usr/include/
RUN cp -R /usr/lib/python2.7  /tmp/rootfs/usr/lib/
RUN cp -R /usr/lib/pymodules  /tmp/rootfs/usr/lib/
RUN cp -R /usr/lib/pyshared  /tmp/rootfs/usr/lib/
RUN cp /usr/bin/python2.7  /tmp/rootfs/usr/bin/
RUN cp /usr/bin/python2.7  /tmp/rootfs/usr/bin/python2
RUN cp /usr/bin/python2.7  /tmp/rootfs/usr/bin/python
RUN cp /usr/bin/python2.7-config  /tmp/rootfs/usr/bin/
RUN cp /usr/bin/python2.7-config  /tmp/rootfs/usr/bin/python2-config
RUN cp /usr/bin/python2.7-config  /tmp/rootfs/usr/bin/python-config

RUN cp -R /usr/local/bin /tmp/rootfs/usr/local/
RUN cp -R /usr/local/lib /tmp/rootfs/usr/local/

RUN rm /tmp/rootfs/usr/lib/libjpeg.*
RUN cp /lib/x86_64-linux-gnu/liblzma* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/liblzma* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libjbig.* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libtiff* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libz.* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libjpeg.* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libfreetype.* /tmp/rootfs/usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libmysqlclient* /tmp/rootfs/usr/lib/mysql/
RUN find /tmp/rootfs -name "*.a" -exec rm '{}' ';'
RUN rm -R /tmp/rootfs/usr/share/locale
RUN rm -R /tmp/rootfs/usr/share/git*
RUN rm -R /tmp/rootfs/usr/share/ImageMagick-6
RUN rm -R /tmp/rootfs/usr/share/perl
RUN find /tmp/rootfs/usr/local/lib/ -name "*.py" -exec rm '{}' ';'

WORKDIR         /tmp/rootfs
RUN             tar -pcf ../rootfs.tar .

# Done!
WORKDIR         /tmp
RUN             md5sum rootfs.tar > rootfs.tar.md5

