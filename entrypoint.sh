#!/bin/bash

set -e
set -u
set -x

git clone https://gitlab.freedesktop.org/pvir/pipewire.git
# git clone https://gitlab.freedesktop.org/pipewire/pipewire.git
cd pipewire
git checkout a2dp-less-skip
# git checkout 7b40ca4f27ece4e4f59041f6ca04197a2a007444
# git checkout 0.3.77

# build
./autogen.sh -Dlibcamera=disabled -Dsession-managers=wireplumber -Dbluez5=enabled
make all

# build process (`make all`) was already made in this container, on the host we will just want to `make run`
sed -i 's/run: all/run:/g' Makefile
