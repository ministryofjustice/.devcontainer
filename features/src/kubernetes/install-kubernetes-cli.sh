#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

VERSION=${KUBERNETESCLIVERSION:-"latest"}

if [[ "${VERSION}" == "latest" ]]; then
  VERSION=$(curl --location --silent https://dl.k8s.io/release/stable.txt)
fi

curl --fail-with-body --location "https://dl.k8s.io/release/${VERSION}/bin/linux/${ARCHITECTURE}/kubectl" \
  --output "kubectl"

install --owner=vscode --group=vscode --mode=775 kubectl /usr/local/bin/kubectl

install --directory --owner=vscode --group=vscode /home/vscode/.kube

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/featurerc.d/kubectl.sh /home/vscode/.devcontainer/featurerc.d/kubectl.sh

rm --force kubectl
