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

PYTHON_VERSION=$1
PYTHON_BIN_DIR=$2/python
PYTHON_TMP_DIR=/tmp/python
PYTHON_BIN_PATH=${PYTHON_BIN_DIR}/python-${PYTHON_VERSION}-$ARCH.tar.gz

mkdir -p $PYTHON_TMP_DIR $PYTHON_BIN_DIR

podman run -v $PYTHON_TMP_DIR:/tmp/python --rm docker.io/library/python:$PYTHON_VERSION-bullseye bash -c "cp -rf /usr/local/* /tmp/python"

cd $PYTHON_TMP_DIR
tar -zcvf $PYTHON_BIN_PATH .
rm -rf $PYTHON_TMP_DIR
cd -
podman rmi -f docker.io/library/python:$PYTHON_VERSION-bullseye
