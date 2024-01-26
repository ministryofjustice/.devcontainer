#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing Terraform CLI (version: ${TERRAFORMCLIVERSION})"
bash "$(dirname "${0}")"/install-terraform-cli.sh
