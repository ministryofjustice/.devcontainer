#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="helm/chart-testing"
VERSION="${HELMCTCLIVERSION:-"latest"}"
YAMALE_VERSION="5.1.0"
YAMLLINT_VERSION="1.35.1"

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

curl --fail-with-body --location "https://github.com/helm/chart-testing/releases/download/${VERSION}/chart-testing_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.tar.gz" \
  --output "chart-testing_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.tar.gz"

tar --extract --file "chart-testing_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.tar.gz"

install --owner=vscode --group=vscode --mode=775 ct /usr/local/bin/ct

install --directory --owner=vscode --group=vscode /home/vscode/.ct

install --owner=vscode --group=vscode --mode=644 etc/chart_schema.yaml /home/vscode/.ct/chart_schema.yaml

install --owner=vscode --group=vscode --mode=644 etc/lintconf.yaml /home/vscode/.ct/lintconf.yaml

rm --recursive --force ct LICENSE README.md etc/chart_schema.yaml etc/lintconf.yaml "chart-testing_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.tar.gz"

pip_install "yamale==${YAMALE_VERSION}"
pip_install "yamllint==${YAMLLINT_VERSION}"
