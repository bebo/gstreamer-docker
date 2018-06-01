#!/bin/bash
set -e
set -x

./install.sh

rsync -av --progress ./gstreamer-1.14.1/*.deb package
rsync -av --progress ./gst-plugins-base-1.14.1/*.deb package
rsync -av --progress ./gst-plugins-good-1.14.1/*.deb package
rsync -av --progress ./gst-plugins-bad-1.14.1/*.deb package
rsync -av --progress ./gst-libav-1.14.1/*.deb package
