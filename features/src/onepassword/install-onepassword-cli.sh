#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

VERSION="${ONEPASSWORDCLIVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  caskVersion="$(curl --silent https://formulae.brew.sh/api/cask/1password-cli.json | jq -r '.version')"
  VERSION="${caskVersion}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

curl --fail-with-body --location "https://cache.agilebits.com/dist/1P/op2/pkg/v${VERSION}/op_linux_${ARCHITECTURE}_v${VERSION}.zip" \
  --output "op_linux_${ARCHITECTURE}_v${VERSION}.zip"

unzip -o "op_linux_${ARCHITECTURE}_v${VERSION}.zip"

install --owner=vscode --group=vscode --mode=755 "op" "/usr/local/bin/op"

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/featurerc.d/onepassword.sh /home/vscode/.devcontainer/featurerc.d/onepassword.sh

rm --force "op_linux_${ARCHITECTURE}_v${VERSION}.zip" op op.sig
