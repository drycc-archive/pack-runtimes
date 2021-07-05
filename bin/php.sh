PHP_VERSION=$1
PHP_BIN_DIR=$2/php
PHP_TMP_DIR=/tmp/php
PHP_BIN_PATH=${PHP_BIN_DIR}/php-${PHP_VERSION}-$(dpkg --print-architecture).tar.gz

mkdir -p $PHP_TMP_DIR $PHP_BIN_DIR

docker run -v $PHP_TMP_DIR:/tmp/php --rm -it docker.io/library/php:$PHP_VERSION-fpm bash -c "cp -rf /usr/local/* /tmp/php"

cd $PHP_TMP_DIR
tar -zcvf $PHP_BIN_PATH .
rm -rf $PHP_TMP_DIR
