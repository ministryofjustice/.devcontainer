#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="synfinatic/aws-sso-cli"
VERSION="${AWSVAULTVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

curl --fail-with-body --location "https://github.com/${GITHUB_REPOSITORY}/releases/download/${VERSION}/aws-sso-${VERSION_STRIP_V}-linux-${ARCHITECTURE}" \
  --output "aws-sso"

install --owner=vscode --group=vscode --mode=775 aws-sso /usr/local/bin/aws-sso

install --directory --owner=vscode --group=vscode /home/vscode/.aws-sso

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.aws-sso/config.yaml /home/vscode/.aws-sso/config.yaml

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/featurerc.d/aws-sso-cli.sh /home/vscode/.devcontainer/featurerc.d/aws-sso-cli.sh

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/promptrc.d/aws-sso-cli.sh /home/vscode/.devcontainer/promptrc.d/aws-sso-cli.sh

awsSsoFilePassword=$(openssl rand -hex 32)
export awsSsoFilePassword

sed --in-place "s/REPLACE_ME/${awsSsoFilePassword}/g" /home/vscode/.devcontainer/featurerc.d/aws-sso-cli.sh

aws-sso --config /home/vscode/.aws-sso/config.yaml completions --source --shell=zsh >> /home/vscode/.devcontainer/featurerc.d/aws-sso-cli.sh

rm --force aws-sso
