#!/bin/sh

# Fail on all errors
set -e

WORK_DIR=$1

if [ "" = "$WORK_DIR" ]; then
  WORK_DIR=$(pwd)
  echo "No working directory has been provided. Using current directory: $WORK_DIR."
fi

# Build the Docker image
docker create --privileged -ti -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /tmp/.X0-lock:/tmp/.X0-lock \
 -v ${WORK_DIR}:/work -w /work --publish-all --name devrust devrust:latest
