#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "kubectl version" kubectl version --client=true --output yaml
check "kubectl featurerc existence" stat /home/vscode/.devcontainer/featurerc.d/kubectl.sh

reportResults
