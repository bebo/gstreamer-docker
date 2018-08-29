FROM python:3.6.6-stretch

RUN apt update && apt -y install \
    autopoint \
    autotools-dev \
    bison \
    build-essential \
    ffmpeg \
    flex \
    git \
    gtk-doc-tools \
    libgirepository1.0-dev \
    librtmp-dev \
    libx264-dev \
    openssh-client \
    python3-venv \
    yasm \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /bebo/gstreamer

COPY . .

RUN sh install.sh && rm -rf ./*/ && rm -rf ./*.tar.xz

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib/cuda-9.2:${LD_LIBRARY_PATH}
ENV GI_TYPELIB_PATH=/usr/local/lib/girepository-1.0:${GI_TYPELIB_PATH}
ENV GST_PLUGIN_PATH=/usr/local/lib/gstreamer-1.0:${GST_PLUGIN_PATH}
