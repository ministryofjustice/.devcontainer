#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing AWS CLI (version: ${AWSCLIVERSION})"
bash "$(dirname "${0}")"/install-aws-cli.sh

logger "info" "Installing AWS SSO CLI (version: ${AWSSSOCLIVERSION})"
bash "$(dirname "${0}")"/install-aws-sso-cli.sh
