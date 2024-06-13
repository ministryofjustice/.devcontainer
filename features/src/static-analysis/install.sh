#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing Checkov CLI (version: ${CHECKOVCLIVERSION})"
bash "$(dirname "${0}")"/install-checkov-cli.sh

logger "info" "Installing Terrascan CLI (version: ${TERRASCANCLIVERSION})"
bash "$(dirname "${0}")"/install-terrascan-cli.sh

logger "info" "Installing Trivy CLI (version: ${TRIVYCLIVERSION})"
bash "$(dirname "${0}")"/install-trivy-cli.sh
