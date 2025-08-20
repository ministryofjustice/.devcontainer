#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing 1Password CLI (version: ${ONEPASSWORDCLIVERSION})"
bash "$(dirname "${0}")"/install-onepassword-cli.sh
