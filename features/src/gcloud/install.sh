#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing Google Cloud CLI (version: ${GCLOUDCLIVERSION})"
bash "$(dirname "${0}")"/install-gcloud-cli.sh
