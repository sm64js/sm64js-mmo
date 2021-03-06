#!/bin/bash
set -e

GIT_HASH=$(git rev-parse HEAD)
echo "using git hash $GIT_HASH"

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker pull sm64js/sm64js || true
docker build --cache-from=sm64js/sm64js -t sm64js/sm64js .
docker push sm64js/sm64js:latest
docker tag sm64js/sm64js sm64js/sm64js:$GIT_HASH
docker push sm64js/sm64js:$GIT_HASH
