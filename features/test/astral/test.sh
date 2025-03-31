#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "uv version" uv --version
check "uvx version" uvx --version
check "uv featurerc existence" stat /home/vscode/.devcontainer/featurerc.d/uv.sh

check "ruff version" ruff --version
check "ruff featurerc existence" stat /home/vscode/.devcontainer/featurerc.d/ruff.sh

reportResults
