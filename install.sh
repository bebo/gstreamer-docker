LD_LIBRARY_PATH=/usr/local/lib


### gstreamer
rm gstreamer-1.14.1.tar.xz
wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.14.1.tar.xz

rm -rf gstreamer-1.14.1
tar xvf gstreamer-1.14.1.tar.xz

cd gstreamer-1.14.1

./autogen.sh --enable-introspection
make -j2

checkinstall -D -y --install=no make install

cd ..

## base
rm gst-plugins-base-1.14.1.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.14.1.tar.xz

rm -rf gst-plugins-base-1.14.1
tar xvf gst-plugins-base-1.14.1

cd gst-plugins-base-1.14.1

./autogen.sh --enable-introspection
make -j2

checkinstall -D -y --install=no make install

## good 
rm gst-plugins-good-1.14.1.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.14.1.tar.xz

rm -rf gst-plugins-good-1.14.1
tar xvf gst-plugins-good-1.141.1

cd gst-plugins-good-1.14.1

./autogen.sh --enable-introspection
make -j2

checkinstall -D -y --install=no make install

## bad 
rm gst-plugins-bad-1.14.1.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.14.1.tar.xz

rm -rf gst-plugins-bad-1.14.1
tar xvf gst-plugins-bad-1.141.1

cd gst-plugins-bad-1.14.1

./autogen.sh --enable-introspection
make -j2

checkinstall -D -y --install=no make install

## av 
rm gst-libav-1.14.1.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-1.14.1.tar.xz

rm -rf gst-libav-1.14.1
tar xvf gst-libav-1.141.1

cd gst-libav-1.14.1

./autogen.sh --enable-introspection
make -j2

checkinstall -D -y --install=no make install

