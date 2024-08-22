#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="terraform-linters/tflint"
VERSION="${TFLINTVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

curl --fail-with-body --location "https://github.com/terraform-linters/tflint/releases/download/${VERSION}/tflint_linux_${ARCHITECTURE}.zip" \
  --output "tflint_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.zip"

unzip "tflint_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.zip"

install --owner=vscode --group=vscode --mode=775 tflint /usr/local/bin/tflint

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/featurerc.d/tflint-cli.sh /home/vscode/.devcontainer/featurerc.d/tflint-cli.sh

rm --recursive --force tflint "tflint_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.zip"
