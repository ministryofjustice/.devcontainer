#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="hashicorp/terraform"
VERSION="${TERRAFORMCLIVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

curl --fail-with-body --location "https://releases.hashicorp.com/terraform/${VERSION_STRIP_V}/terraform_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.zip" \
  --output "terraform_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.zip"

unzip "terraform_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.zip"

install --owner=vscode --group=vscode --mode=775 terraform /usr/local/bin/terraform

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/featurerc.d/terraform.sh /home/vscode/.devcontainer/featurerc.d/terraform.sh

rm --recursive --force terraform "terraform_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.zip"
