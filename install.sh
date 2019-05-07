#!/bin/sh

GST_VERSION=1.16
GST_BUILD_BRANCH=7fb7739337eb1cb05a925b268c1381423654068e

git clone https://github.com/gstreamer/gst-build.git

cd gst-build

git checkout $GST_BUILD_BRANCH

meson build/ \
  -Dgst-plugins-base:gl=enabled \
  -Dgst-plugins-bad:nvdec=enabled \
  -Dpython=enabled \
  -Dgi=enabled \
  -Dpygobject=enabled \
  -Dpygobject:pycairo=false

./checkout-branch-worktree ./gst-build-branch $GST_VERSION -C build/

cd ./gst-build-branch

meson build/ \
  -Dgst-plugins-base:gl=enabled \
  -Dgst-plugins-bad:nvdec=enabled \
  -Dpython=enabled \
  -Dgi=enabled \
  -Dpygobject=enabled \
  -Dpygobject:pycairo=false

ninja -C build install

# Required
# Xvfb :20 -screen 0 1280x720x24+32 &
# export DISPLAY=:20


# To test:
# gst-launch-1.0 videotestsrc is-live=true ! video/x-raw,width=1280,height=720,framerate=1/30 ! x264enc ! h264parse ! nvdec ! fakesink

