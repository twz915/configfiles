#!/usr/bin/env bash
# compile requirements
sudo yum install cmake doxygen -y

cd /tmp/
curl -o opencc.1.0.5.tar.gz -L https://github.com/BYVoid/OpenCC/archive/ver.1.0.5.tar.gz

tar -xf opencc.1.0.5.tar.gz

cd OpenCC-ver.1.0.5
make -j4
sudo make install

# fix bug: http://blog.41ms.com/post/54.html
sudo ln -s /usr/lib/libopencc.so.2 /usr/lib64/libopencc.so.2

echo '軟件已經安裝成功，OpenCC 嚴格區分「一簡對多繁」和「一簡對多異」' | opencc -c t2s
