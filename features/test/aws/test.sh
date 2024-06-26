#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "aws version" aws --version
check "aws featurerc existence" stat /home/vscode/.devcontainer/featurerc.d/aws-cli.sh

check "aws-sso version" aws-sso version
check "aws-sso configuration existence" stat /home/vscode/.aws-sso/config.yaml
check "aws-sso featurerc existence" stat /home/vscode/.devcontainer/featurerc.d/aws-sso-cli.sh
# shellcheck disable=SC2015
check "aws-sso featurerc password" source /home/vscode/.devcontainer/featurerc.d/aws-sso-cli.sh && [[ "${AWS_SSO_FILE_PASSWORD}" == "REPLACE_ME" ]] && exit 1 || true
check "aws-sso promptrc existence" stat /home/vscode/.devcontainer/promptrc.d/aws-sso-cli.sh

reportResults
