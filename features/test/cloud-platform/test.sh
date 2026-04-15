#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "cloud-platform version" cloud-platform version
check "cloud-platform completions existence" stat /usr/local/share/zsh/site-functions/_cloud-platform
check "cloud-platform kubeconfig existence" stat /home/vscode/.kube/config
check "cloud-platform prompt existence" stat /home/vscode/.devcontainer/promptrc.d/cloud-platform.sh

reportResults
