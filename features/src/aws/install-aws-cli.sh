#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

VERSION="${AWSCLIVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  ARTEFACT="awscli-exe-linux-$(uname --machine).zip"
else
  ARTEFACT="awscli-exe-linux-$(uname --machine)-${VERSION}.zip"
fi

curl --fail-with-body --location "https://awscli.amazonaws.com/${ARTEFACT}" \
  --output "${ARTEFACT}"

unzip "${ARTEFACT}"

bash ./aws/install

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/featurerc.d/aws-cli.sh /home/vscode/.devcontainer/featurerc.d/aws-cli.sh

rm --recursive --force aws "${ARTEFACT}"
