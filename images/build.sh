#!/usr/bin/env bash
set -xe

GH_USER=${GH_USER:-ilackarms}
IMAGE_TYPE=${IMAGE_TYPE:-unstable}
BRANCH_REF=image-${IMAGE_TYPE}

export BASE_IMAGE="miq-app-base-${IMAGE_TYPE}"
export FINAL_IMAGE="docker.io/${GH_USER}/miq-app-frontend-${IMAGE_TYPE}:latest"

pushd miq-app
docker build -t ${BASE_IMAGE} --no-cache --build-arg GHORG=${GH_USER} --build-arg REF=${BRANCH_REF} .
popd

pushd miq-app-frontend
echo "#THIS FILE IS GENERATED BY build.sh DO NOT EDIT" > Dockerfile
cat Dockerfile.base | sed "s/FROM BASE_IMAGE/FROM ${BASE_IMAGE}/g" >> Dockerfile
docker build -t --build-arg REF=${BRANCH_REF} ${FINAL_IMAGE} .
popd
