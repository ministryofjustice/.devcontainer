#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "checkov version" checkov --version
check "trivy version" trivy --version
check "terrascan version" terrascan version

reportResults
