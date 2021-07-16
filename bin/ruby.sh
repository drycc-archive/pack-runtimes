RUBY_VERSION=$1
RUBY_BIN_DIR=$2/ruby
RUBY_TMP_DIR=/tmp/ruby
RUBY_BIN_PATH=${RUBY_BIN_DIR}/ruby-${RUBY_VERSION}-$(dpkg --print-architecture).tar.gz

mkdir -p $RUBY_TMP_DIR $RUBY_BIN_DIR

docker run -v $RUBY_TMP_DIR:/tmp/ruby --rm -it docker.io/library/ruby:$RUBY_VERSION bash -c "cp -rf /usr/local/* /tmp/ruby"

cd $RUBY_TMP_DIR
tar -zcvf $RUBY_BIN_PATH .
rm -rf $RUBY_TMP_DIR
docker rmi -f docker.io/library/ruby:$RUBY_VERSION
