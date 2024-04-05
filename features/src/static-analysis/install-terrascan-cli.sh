#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="tenable/terrascan"
VERSION="${TRIVYCLIVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

ARCHITECTURE=$(uname --machine)
export ARCHITECTURE

curl --fail-with-body --location "https://github.com/${GITHUB_REPOSITORY}/releases/download/${VERSION}/terrascan_${VERSION_STRIP_V}_Linux_${ARCHITECTURE}.tar.gz" \
  --output "terrascan_${VERSION_STRIP_V}_Linux_${ARCHITECTURE}.tar.gz"

tar --extract --file "terrascan_${VERSION_STRIP_V}_Linux_${ARCHITECTURE}.tar.gz"

install --owner=vscode --group=vscode --mode=775 terrascan /usr/local/bin/terrascan

rm --recursive --force rm -rf terrascan LICENSE README.md CHANGELOG.md "terrascan_${VERSION_STRIP_V}_Linux_${ARCHITECTURE}.tar.gz"
