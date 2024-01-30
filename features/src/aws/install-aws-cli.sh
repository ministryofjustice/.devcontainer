#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

VERSION="${AWSCLIVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  ARTEFACT="awscli-exe-linux-$(uname -m).zip"
else
  ARTEFACT="awscli-exe-linux-$(uname -m)-${VERSION}.zip"
fi

curl --fail-with-body --location "https://awscli.amazonaws.com/${ARTEFACT}" \
  --output "${ARTEFACT}"

unzip "${ARTEFACT}"

bash ./aws/install

rm --recursive --force aws "${ARTEFACT}"

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/featurerc.d/aws.sh /home/vscode/.devcontainer/featurerc.d/aws.sh
