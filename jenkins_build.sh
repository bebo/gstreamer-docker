#!/bin/bash
set -e
set -x

./install.sh

rsync -av --progress ./gstreamer-1.14.1/*.deb package
