#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing Kubernetes CLI (version: ${KUBERNETESCLIVERSION})"
bash "$(dirname "${0}")"/install-kubernetes-cli.sh
