#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing Cloud Platform CLI (version: ${CLOUDPLATFORMCLIVERSION})"
bash "$(dirname "${0}")"/install-cloud-platform-cli.sh
