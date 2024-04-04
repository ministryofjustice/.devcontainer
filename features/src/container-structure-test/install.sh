#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing Container Structure Test (version: ${CONTAINERSTRUCTURETESTVERSION})"
bash "$(dirname "${0}")"/install-container-structure-test.sh
