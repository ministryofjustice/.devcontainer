#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing apm (version: ${APMVERSION})"
bash "$(dirname "${0}")"/install-apm.sh

if [ -f "apm.yml" ]; then
  logger "info" "Installing apm packages defined in apm.yml"
  apm install
else
  logger "info" "No apm.yml found in $(pwd); skipping apm package installation"
fi
