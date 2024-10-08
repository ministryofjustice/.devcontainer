#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="ministryofjustice/cloud-platform-cli"
VERSION=${CLOUDPLATFORMCLIVERSION:-"latest"}
INSTALL_CLOUD_PLATFORM_KUBECONFIG=${INSTALLCLOUDPLATFORMKUBECONFIG:-"true"}
INSTALL_CLOUD_PLATFORM_PROMPT=${INSTALLCLOUDPLATFORMPROMPT:-"true"}

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

curl --fail-with-body --location "https://github.com/${GITHUB_REPOSITORY}/releases/download/${VERSION}/cloud-platform-cli_${VERSION}_linux_${ARCHITECTURE}.tar.gz" \
  --output "cloud-platform-cli_${VERSION}_linux_${ARCHITECTURE}.tar.gz"

tar --gzip --extract --file "cloud-platform-cli_${VERSION}_linux_${ARCHITECTURE}.tar.gz"

install --owner=vscode --group=vscode --mode=775 cloud-platform /usr/local/bin/cloud-platform

install --owner=vscode --group=vscode --mode=775 completions/cloud-platform.zsh /usr/local/share/zsh/site-functions/_cloud-platform

if [[ "${INSTALL_CLOUD_PLATFORM_KUBECONFIG}" == "true" ]]; then
  install --owner=vscode --group=vscode --mode=0600 "$(dirname "${0}")"/src/home/vscode/.kube/config /home/vscode/.kube/config
fi

if [[ "${INSTALL_CLOUD_PLATFORM_PROMPT}" == "true" ]]; then
  install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/promptrc.d/cloud-platform.sh /home/vscode/.devcontainer/promptrc.d/cloud-platform.sh
fi

rm --recursive --force cloud-platform LICENSE README.md completions "cloud-platform-cli_${VERSION}_linux_${ARCHITECTURE}.tar.gz"
