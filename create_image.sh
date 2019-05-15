#!/bin/sh

# Fail on all errors
set -e

# The path to this script
SCRIPT_PATH=$(dirname $(readlink -e ${0}))

# Retrieve the user ID and group ID for the current user
USER_ID=$(id -u)
GROUP_ID=$(id -u)

# Build the Docker image
docker build --tag devrust:latest --build-arg USER_ID=$USER_ID --build-arg GROUP_ID=$GROUP_ID $SCRIPT_PATH
