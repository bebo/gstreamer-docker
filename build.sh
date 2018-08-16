#!/bin/bash
set -e
set -x

docker build -t ${JOB_NAME}:${TAG} --rm --no-cache .
docker tag ${JOB_NAME}:${TAG} bebodev/${JOB_NAME}:${TAG}
docker push bebodev/${JOB_NAME}
