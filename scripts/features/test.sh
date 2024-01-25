#!/usr/bin/env bash

FEATURE_TO_TEST="${1}"

docker build \
  --file images/base/Dockerfile \
  --tag ghcr.io/ministryofjustice/devcontainer-base:local-feature-test \
  images/base

devcontainer features test \
  --project-folder features \
  --features "${FEATURE_TO_TEST}" \
  --skip-scenarios \
  --skip-duplicated \
  --base-image ghcr.io/ministryofjustice/devcontainer-base:local-feature-test
