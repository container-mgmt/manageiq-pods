#!/usr/bin/env bash

export BASE_IMAGE="miq-app-base"
export FINAL_IMAGE="docker.io/ilackarms/miq-app-frontend:latest"
if [-z $1 ]; then
    export BASE_IMAGE=$1
fi
if [-z $2 ]; then
    export FINAL_IMAGE=$2
fi

pushd miq-app
docker build -t ${BASE_IMAGE} .
popd

pushd miq-app-frontend
cat Dockerfile.base | sed "s/FROM BASE_IMAGE/FROM ${BASE_IMAGE}/g" > Dockerfile
docker build -t ${FINAL_IMAGE} .
popd
