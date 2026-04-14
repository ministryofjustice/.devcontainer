#!/usr/bin/env bash

docker build \
  --file images/base/Dockerfile \
  --tag ghcr.io/ministryofjustice/devcontainer-base:local-feature-debug \
  images/base

docker run -it --rm \
  --volume "${PWD}":/workspace \
  --volume "${PWD}"/images/base/src/usr/local/bin/devcontainer-utils:/usr/local/bin/devcontainer-utils \
  --name local-feature-debug \
  ghcr.io/ministryofjustice/devcontainer-base:local-feature-debug
