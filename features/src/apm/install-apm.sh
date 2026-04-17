#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="microsoft/apm"
VERSION=${APMVERSION:-"latest"}

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
fi

curl --fail-with-body --location "https://github.com/${GITHUB_REPOSITORY}/releases/download/${VERSION}/apm-linux-${ARCHITECTURE}.tar.gz" \
  --output "apm-linux-${ARCHITECTURE}.tar.gz"

tar --gzip --extract --file "apm-linux-${ARCHITECTURE}.tar.gz"

install --owner=vscode --group=vscode --mode=775 "apm-linux-${ARCHITECTURE}/apm" /usr/local/bin/apm

cp --archive "apm-linux-${ARCHITECTURE}/_internal" /usr/local/bin/_internal

chown --recursive vscode:vscode /usr/local/bin/_internal

rm -rf "apm-linux-${ARCHITECTURE}.tar.gz" "apm-linux-${ARCHITECTURE}"
