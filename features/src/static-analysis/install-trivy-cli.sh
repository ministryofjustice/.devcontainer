#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="aquasecurity/trivy"
VERSION="${TRIVYCLIVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

if [[ "${ARCHITECTURE}" == "amd64" ]]; then
  ARCHITECTURE="64bit"
elif [[ "${ARCHITECTURE}" == "arm64" ]]; then
  ARCHITECTURE="ARM64"
fi

curl --fail-with-body --location "https://github.com/${GITHUB_REPOSITORY}/releases/download/${VERSION}/trivy_${VERSION_STRIP_V}_Linux-${ARCHITECTURE}.tar.gz" \
  --output "trivy_${VERSION_STRIP_V}_Linux-${ARCHITECTURE}.tar.gz"

tar --extract --file "trivy_${VERSION_STRIP_V}_Linux-${ARCHITECTURE}.tar.gz"

install --owner=vscode --group=vscode --mode=775 trivy /usr/local/bin/trivy

rm --recursive --force trivy LICENSE README.md contrib "trivy_${VERSION_STRIP_V}_Linux-${ARCHITECTURE}.tar.gz"
