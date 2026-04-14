#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing Checkov CLI (version: ${CHECKOVCLIVERSION})"
bash "$(dirname "${0}")"/install-checkov-cli.sh
