#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing Checkov CLI (version: ${CHECKOVVERSION})"
bash "$(dirname "${0}")"/install-checkov-cli.sh

logger "info" "Installing Terrascan CLI (version: ${TERRASCANVERSION})"
bash "$(dirname "${0}")"/install-terrascan-cli.sh

logger "info" "Installing Trivy CLI (version: ${TRIVYVERSION})"
bash "$(dirname "${0}")"/install-trivy-cli.sh
