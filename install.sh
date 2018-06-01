LD_LIBRARY_PATH=/usr/local/lib

set -e

### gstreamer
wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.14.1.tar.xz
tar xvf gstreamer-1.14.1.tar.xz

cd gstreamer-1.14.1

./autogen.sh --enable-introspection
make -j2

checkinstall -D -y --install=no make install

cd ..

## base
wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.14.1.tar.xz
tar xvf gst-plugins-base-1.14.1.tar.xz
cd gst-plugins-base-1.14.1
./autogen.sh --enable-introspection
make -j2
checkinstall -D -y --install=no make install
cd ..

## good 
wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.14.1.tar.xz
tar xvf gst-plugins-good-1.14.1.tar.xz
cd gst-plugins-good-1.14.1
./autogen.sh --enable-introspection
make -j2
checkinstall -D -y --install=no make install
cd ..

## bad 
wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.14.1.tar.xz
tar xvf gst-plugins-bad-1.14.1.tar.xz
cd gst-plugins-bad-1.14.1
./autogen.sh --enable-introspection
make -j2
checkinstall -D -y --install=no make install
cd ..

## av 
wget https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-1.14.1.tar.xz
tar xvf gst-libav-1.14.1.tar.xz
cd gst-libav-1.14.1
./autogen.sh --enable-introspection
make -j2
checkinstall -D -y --install=no make install
