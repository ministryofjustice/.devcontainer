#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="terraform-docs/terraform-docs"
VERSION="${TERRAFORMDOCSVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

curl --fail-with-body --location "https://github.com/terraform-docs/terraform-docs/releases/download/${VERSION}/terraform-docs-${VERSION}-linux-${ARCHITECTURE}.tar.gz" \
  --output "terraform-docs-${VERSION}-linux-${ARCHITECTURE}.tar.gz"

tar --gzip --extract --file "terraform-docs-${VERSION}-linux-${ARCHITECTURE}.tar.gz" terraform-docs

install --owner=vscode --group=vscode --mode=775 "terraform-docs" "/usr/local/bin/terraform-docs"

rm --recursive --force "terraform-docs" "terraform-docs-${VERSION}-linux-${ARCHITECTURE}.tar.gz"
