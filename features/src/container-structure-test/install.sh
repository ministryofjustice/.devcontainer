#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing Container Structure Test CLI (version: ${CONTAINERSTRUCTURETESTCLIVERSION})"
bash "$(dirname "${0}")"/install-container-structure-test-cli.sh
