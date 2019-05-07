FROM nvidia/cuda:9.2-devel

RUN apt update && apt -y install \
      bison \
      flex \
      pkg-config \
      autotools-dev \
      libgirepository1.0-dev \
      librtmp-dev \
      libx264-dev \
      libsoup2.4-1 \
      libsoup2.4-dev \
      libpng-dev \
      libnvidia-gl-390 \
      libnvidia-decode-390 \
      libnvidia-encode-390 \
      libgl1-mesa-dev \
      libgl1-mesa-glx \
      curl \
      build-essential \
      ninja-build \
      git \
      python3.7 \
      python3-distutils \
      python3-pip \
      xvfb \
      && rm -rf /var/lib/apt/lists/*

WORKDIR /bebo/gstreamer

RUN pip3 install meson

ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/lib/x86_64-linux-gnu"

