FROM nvidia/cuda:10.0-devel

WORKDIR /bebo/gstreamer

RUN apt-get update && apt-get -y install \
      libmount-dev \
      bison \
      flex \
      pkg-config \
      autotools-dev \
      libffi-dev \
      python3.6 \
      python3.6-dev \
      python3-distutils \
      python3-pip \
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
      xvfb

RUN rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 9
RUN update-alternatives --set python3 /usr/bin/python3.6

RUN python3 -m pip install meson

ENV BUILD_JOB_COUNT=16
ENV GOBJECT_INTROSPECTION_BRANCH=1.60.1
RUN git clone https://github.com/GNOME/gobject-introspection.git && \
      cd gobject-introspection && \
      git checkout $GOBJECT_INTROSPECTION_BRANCH && \
      meson build -Dpython=/usr/bin/python3.6  && \
      ninja -j $BUILD_JOB_COUNT -C build install

ENV GST_BUILD_BRANCH=81ee66aa743e1157f8501ba87df13c39d8782e7d
RUN git clone https://github.com/bebo/gst-build.git && \
    cd gst-build && \
    git checkout $GST_BUILD_BRANCH

ENV GST_VERSION=1.16

RUN cd ./gst-build && \
    meson build/ && \
    ./checkout-branch-worktree ./gst-build-branch $GST_VERSION -C build/

RUN cd ./gst-build/gst-build-branch && \
    meson build \
        -Dintrospection=enabled \
        -Dexamples=disabled \
        -Dgtk_doc=disabled \
        -Dbenchmarks=disabled \
        -Dgstreamer:tests=disabled \
        -Dgstreamer:benchmarks=disabled \
        -Dgst-plugins-base:tests=disabled \
        -Dgst-plugins-good:tests=disabled \
        -Dgst-plugins-bad:tests=disabled \
        -Dgst-plugins-ugly:tests=disabled \
        -Dgst-plugins-base:gl=enabled \
        -Dgst-plugins-bad:nvdec=enabled \
        -Dgi=disabled \
        -Dpython=enabled \
        -Dgst-python:python=/usr/bin/python3.6 \
        -Dpygobject=enabled \
        -Dpygobject:python=/usr/bin/python3.6 \
        -Dpygobject:pycairo=false \
        -Dgobject-introspection:python=/usr/bin/python3.6

RUN cd ./gst-build/gst-build-branch && \
    ninja -j $BUILD_JOB_COUNT -C build install

ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}
ENV GI_TYPELIB_PATH=/usr/lib/x86_64-linux-gnu/girepository-1.0:/usr/local/lib/x86_64-linux-gnu/girepository-1.0
