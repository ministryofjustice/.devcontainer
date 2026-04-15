#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing Kubernetes CLI (version: ${KUBERNETESCLIVERSION})"
bash "$(dirname "${0}")"/install-kubernetes-cli.sh

logger "info" "Installing Helm CLI (version: ${HELMCLIVERSION})"
bash "$(dirname "${0}")"/install-helm-cli.sh

logger "info" "Installing Helm Chart Testing CLI (version: ${HELMCTCLIVERSION})"
bash "$(dirname "${0}")"/install-helm-ct-cli.sh

if [[ "${INSTALLVELEROCLI}" == "true" ]]; then
  logger "info" "Installing Velero CLI (version: ${VELEROCLIVERSION})"
  bash "$(dirname "${0}")"/install-velero-cli.sh
fi
