#!/usr/bin/env sh

wget https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz
tar -xvf emsdk-portable.tar.gz
rm emsdk-portable.tar.gz

apt-get install -qq -y cmake default-jre

cd emsdk-portable
./emsdk update
./emsdk install latest
./emsdk activate latest
source ./emsdk_env.sh


