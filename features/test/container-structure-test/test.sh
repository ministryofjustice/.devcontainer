#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "container-stucture-test version" container-structure-test version
check "container-stucture-test featurerc existence" stat /home/vscode/.devcontainer/featurerc.d/container-structure-test-cli.sh


reportResults
