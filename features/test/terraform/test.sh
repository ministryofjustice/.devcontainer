#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "terraform version" terraform version
check "terraform featurerc existence" stat /home/vscode/.devcontainer/featurerc.d/terraform.sh

reportResults
