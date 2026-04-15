#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="GoogleContainerTools/container-structure-test"
VERSION="${CONTAINERSTRUCTURETESTCLIVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

curl --fail-with-body --location "https://github.com/${GITHUB_REPOSITORY}/releases/download/${VERSION}/container-structure-test-linux-${ARCHITECTURE}" \
  --output "container-structure-test"

install --owner=vscode --group=vscode --mode=775 container-structure-test /usr/local/bin/container-structure-test

container-structure-test completion zsh >>/home/vscode/.devcontainer/featurerc.d/container-structure-test-cli.sh

rm --force container-structure-test
