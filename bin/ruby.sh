#!/usr/bin/env bash
set -eo pipefail

init_arch() {
  ARCH=$(uname -m)
  case $ARCH in
    armv5*) ARCH="armv5";;
    armv6*) ARCH="armv6";;
    armv7*) ARCH="arm";;
    aarch64) ARCH="arm64";;
    x86) ARCH="386";;
    x86_64) ARCH="amd64";;
    i686) ARCH="386";;
    i386) ARCH="386";;
  esac
}
init_arch

RUBY_VERSION=$1
RUBY_BIN_DIR=$2/ruby
RUBY_TMP_DIR=/tmp/ruby
RUBY_BIN_PATH=${RUBY_BIN_DIR}/ruby-${RUBY_VERSION}-$ARCH.tar.gz

mkdir -p $RUBY_TMP_DIR $RUBY_BIN_DIR

podman run -v $RUBY_TMP_DIR:/tmp/ruby --rm docker.io/library/ruby:$RUBY_VERSION-bullseye bash -c "cp -rf /usr/local/* /tmp/ruby"

cd $RUBY_TMP_DIR
tar -zcvf $RUBY_BIN_PATH .
rm -rf $RUBY_TMP_DIR
cd -
podman rmi -f docker.io/library/ruby:$RUBY_VERSION-bullseye
