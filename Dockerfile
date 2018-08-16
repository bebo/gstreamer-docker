FROM python:3.6.6-stretch

RUN apt update
RUN apt -y install openssh-client git build-essential autopoint autotools-dev bison flex libgirepository1.0-dev gtk-doc-tools yasm python3-venv librtmp-dev

COPY . .

RUN sh install.sh
