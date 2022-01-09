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

PHP_VERSION=$1
PHP_BIN_DIR=$2/php
PHP_TMP_DIR=/tmp/php
PHP_BIN_PATH=${PHP_BIN_DIR}/php-${PHP_VERSION}-$ARCH.tar.gz

mkdir -p $PHP_TMP_DIR $PHP_BIN_DIR

podman run -v $PHP_TMP_DIR:/tmp/php --rm docker.io/library/php:$PHP_VERSION-fpm-bullseye bash -c "cp -rf /usr/local/* /tmp/php"

cd $PHP_TMP_DIR
tar -zcvf $PHP_BIN_PATH .
rm -rf $PHP_TMP_DIR
cd -
podman rmi -f docker.io/library/php:$PHP_VERSION-fpm-bullseye
