#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="vmware-tanzu/velero"
VERSION=${VELEROCLIVERSION:-"latest"}

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

curl --fail-with-body --location "https://github.com/${GITHUB_REPOSITORY}/releases/download/${VERSION}/velero-${VERSION}-linux-${ARCHITECTURE}.tar.gz" \
  --output "velero.tar.gz"

mkdir velero

tar --gzip --extract --file velero.tar.gz --directory=velero --strip-components=1

install --owner=vscode --group=vscode --mode=775 velero/velero /usr/local/bin/velero

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/featurerc.d/velero-cli.sh /home/vscode/.devcontainer/featurerc.d/velero-cli.sh

rm --force --recursive velero.tar.gz velero
