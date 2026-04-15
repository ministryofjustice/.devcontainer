#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="helm/helm"
VERSION="${HELMCLIVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

curl --fail-with-body --location "https://get.helm.sh/helm-${VERSION}-linux-${ARCHITECTURE}.tar.gz" \
  --output "helm-${VERSION}-linux-${ARCHITECTURE}.tar.gz"

tar --extract --file "helm-${VERSION}-linux-${ARCHITECTURE}.tar.gz"

install --owner=vscode --group=vscode --mode=775 "linux-${ARCHITECTURE}/helm" /usr/local/bin/helm

install --directory --owner=vscode --group=vscode /home/vscode/.config/helm

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/featurerc.d/helm-cli.sh /home/vscode/.devcontainer/featurerc.d/helm-cli.sh

rm --recursive --force "linux-${ARCHITECTURE}" "helm-${VERSION}-linux-${ARCHITECTURE}.tar.gz"
