#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "kubectl version" kubectl version --client=true --output yaml
check "kubectl featurerc existence" stat /home/vscode/.devcontainer/featurerc.d/kubectl.sh
check "helm version" helm version
check "helm featurerc existence" stat /home/vscode/.devcontainer/featurerc.d/helm.sh
check "helm ct version" ct version
check "helm chart_schema.yaml existence" stat /home/vscode/.ct/chart_schema.yaml
check "helm lintconf.yaml existence" stat /home/vscode/.ct/lintconf.yaml
check "yamale version" yamale --version
check "yamllint version" yamllint --version

reportResults
