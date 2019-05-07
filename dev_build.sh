#!/bin/bash
set -e
set -x

JOB_NAME=gstreamer
ENV=local

docker build -t ${JOB_NAME}:local --rm --build-arg env=${ENV} .
docker run --rm --name ${JOB_NAME} ${JOB_NAME}:local
