#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing apm (version: ${APMVERSION})"
bash "$(dirname "${0}")"/install-apm.sh
