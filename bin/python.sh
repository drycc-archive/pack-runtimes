PYTHON_VERSION=$1
PYTHON_BIN_DIR=$2/python
PYTHON_TMP_DIR=/tmp/python
PYTHON_BIN_PATH=${PYTHON_BIN_DIR}/python-${PYTHON_VERSION}-$(dpkg --print-architecture).tar.gz

mkdir -p $PYTHON_TMP_DIR $PYTHON_BIN_DIR

docker run -v $PYTHON_TMP_DIR:/tmp/python --rm -it docker.io/library/python:$PYTHON_VERSION bash -c "cp -rf /usr/local/* /tmp/python"

cd $PYTHON_TMP_DIR
tar -zcvf $PYTHON_BIN_PATH .
rm -rf $PYTHON_TMP_DIR
