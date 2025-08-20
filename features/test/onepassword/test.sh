#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "op version" op --version
check "onepassword featurerc existence" stat /home/vscode/.devcontainer/featurerc.d/onepassword.sh

reportResults
