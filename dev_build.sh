#!/bin/bash
set -e
set -x

JOB_NAME=gstreamer
ENV=local
sudo docker build -t ${JOB_NAME}:local --rm --no-cache --build-arg env=${ENV} .
sudo docker run --rm --name ${JOB_NAME} ${JOB_NAME}:local
