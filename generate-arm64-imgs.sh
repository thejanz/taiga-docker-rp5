#!/bin/bash
REGISTRY="jjanz4"
CURRENT_VERSION="6.8.0"
IMAGES=("front" "back" "events" "protected")

for image in "${IMAGES[@]}"; do
  git -C "taiga-$image" pull || git clone -b stable https://github.com/taigaio/taiga-$image
  docker buildx build --platform=arm64 -t $REGISTRY/taiga-$image:$CURRENT_VERSION -f taiga-$image/docker/Dockerfile taiga-$image/
  docker push $REGISTRY/taiga-$image:$CURRENT_VERSION
done