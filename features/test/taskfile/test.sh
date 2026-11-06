#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "checkov version" task --version
check "cloud-platform completions existence" stat /usr/local/share/zsh/site-functions/_task

reportResults
