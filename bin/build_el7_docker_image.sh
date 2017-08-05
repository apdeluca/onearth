#!/bin/sh

set -e

if ! ls dist/gibs-gdal-*.el7.*.rpm >/dev/null 2>&1; then
  echo "No RPMs found in ./dist/" >&2
  exit 1
fi

SCRIPT_NAME=$(basename "$0")
TAG="$1"

if [ -z "$TAG" ]; then
  echo "Usage: ${SCRIPT_NAME} TAG" >&2
  exit 1
fi

rm -rf tmp/docker
mkdir -p tmp/docker/rpms
cp dist/onearth-*.el7.*.rpm tmp/docker/rpms/
cp docker/el7/run-onearth.sh tmp/docker/run-onearth.sh

echo "FROM $(cat docker/el7/gibs-gdal-image.txt)" > tmp/docker/Dockerfile
grep -Ev '^FROM' docker/el7/Dockerfile >> tmp/docker/Dockerfile

(
  set -e
  cd tmp/docker
  docker build -t "$TAG" .)


rm -rf tmp/docker
