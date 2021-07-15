import os
import sys
import oss2


bucket = oss2.Bucket(
    oss2.Auth(
        os.environ.get("OSS_ACCESS_KEY_ID"),
        os.environ.get("OSS_ACCESS_KEY_SECRET"),
    ),
    os.environ.get("OSS_ENDPOINT", "http://oss-accelerate.aliyuncs.com"),
    'buildpacks'
)


def upload(filename, filepath):
    with open(filepath, "rb") as f:
        result = bucket.put_object(filename, f.read())
        print("upload %s %s" % (filename, result.status))


def upload_list(path, version):
    for root, dirs, files in os.walk(path):
        for _filename in  files:
            filename = os.path.join(root.split(os.sep)[-1], version, _filename)
            filepath = os.path.join(root, _filename)
            upload(filename, filepath)
        


if __name__ == "__main__":
    upload_list(sys.argv[1], sys.argv[2])
