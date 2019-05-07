FROM nvidia/cuda:9.2-devel

WORKDIR /bebo/gstreamer

RUN apt-get update && apt-get -y install \
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

RUN pip3 install meson

ENV GST_BUILD_BRANCH=7fb7739337eb1cb05a925b268c1381423654068e

RUN git clone https://github.com/gstreamer/gst-build.git && \
    cd gst-build && \
    git checkout $GST_BUILD_BRANCH

ENV GST_VERSION=1.16

RUN cd ./gst-build && \
    meson build/ \
        -Dgst-plugins-base:gl=enabled \
        -Dgst-plugins-bad:nvdec=enabled \
        -Dpython=enabled \
        -Dgi=enabled \
        -Dpygobject=enabled \
        -Dpygobject:pycairo=false

RUN cd ./gst-build && \
    ./checkout-branch-worktree ./gst-build-branch $GST_VERSION -C build/

RUN cd ./gst-build/gst-build-branch && \
    meson build/ \
      -Dgst-plugins-base:gl=enabled \
      -Dgst-plugins-bad:nvdec=enabled \
      -Dpython=enabled \
      -Dgi=enabled \
      -Dpygobject=enabled \
      -Dpygobject:pycairo=false

RUN cd ./gst-build/gst-build-branch && \
    ninja -C build install

ENV LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}
ENV GI_TYPELIB_PATH=/usr/lib/x86_64-linux-gnu/girepository-1.0
