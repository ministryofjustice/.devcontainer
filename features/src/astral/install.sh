#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

logger "info" "Installing uv (version: ${UVVERSION})"
bash "$(dirname "${0}")"/install-uv.sh

logger "info" "Installing ruff (version: ${RUFFVERSION})"
bash "$(dirname "${0}")"/install-ruff.sh
