#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="astral-sh/uv"
VERSION=${UVVERSION:-"latest"}

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

if [[ "${ARCHITECTURE}" == "amd64" ]]; then
  ARCHITECTURE="x86_64"
else
  ARCHITECTURE="aarch64"
fi

curl --fail-with-body --location "https://github.com/${GITHUB_REPOSITORY}/releases/download/${VERSION}/uv-${ARCHITECTURE}-unknown-linux-gnu.tar.gz" \
  --output "uv.tar.gz"

tar --gzip --extract --file "uv.tar.gz"

install --owner=vscode --group=vscode --mode=775 "uv-${ARCHITECTURE}-unknown-linux-gnu/uv" /usr/local/bin/uv

install --owner=vscode --group=vscode --mode=775 "uv-${ARCHITECTURE}-unknown-linux-gnu/uvx" /usr/local/bin/uvx

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/featurerc.d/uv.sh /home/vscode/.devcontainer/featurerc.d/uv.sh

rm --recursive --force "uv-${ARCHITECTURE}-unknown-linux-gnu" "uv.tar.gz"
