LD_LIBRARY_PATH=/usr/local/lib

rm gstreamer-1.14.1.tar.xz
wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.14.1.tar.xz

rm -rf gstreamer-1.14.1
tar xvf gstreamer-1.14.1.tar.xz

cd gstreamer-1.14.1

./autogen.sh --enable-instrospection
make -j2

checkinstall -D -y --install=no make install


cd ..


