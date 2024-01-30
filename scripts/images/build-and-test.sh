#!/usr/bin/env bash

IMAGE="${1}"
IMAGE_DIRECTORY="images/${IMAGE}"
IMAGE_TAG="ghcr.io/ministryofjustice/devcontainer-${IMAGE}:local"
CONTAINER_STRUCTURE_TEST_IMAGE="gcr.io/gcp-runtimes/container-structure-test:latest"

echo "Building [ ${IMAGE} ] as [ ${IMAGE_TAG} ]"

docker build --file "${IMAGE_DIRECTORY}/Dockerfile" --tag "${IMAGE_TAG}" "${IMAGE_DIRECTORY}"

if [[ -f "${IMAGE_DIRECTORY}/test/container-structure-test.yml" ]]; then
  echo "Running container structure test for [ ${IMAGE_TAG} ]"

  docker run --rm \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume "${PWD}:/workspace" \
    --workdir /workspace \
    "${CONTAINER_STRUCTURE_TEST_IMAGE}" \
    test --image "${IMAGE_TAG}" --config "/workspace/${IMAGE_DIRECTORY}/test/container-structure-test.yml"
fi
