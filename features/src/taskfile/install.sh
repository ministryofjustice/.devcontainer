#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="go-task/task"
VERSION=${TASKFILEVERSION:-"latest"}

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

curl --fail-with-body --location "https://github.com/${GITHUB_REPOSITORY}/releases/download/${VERSION}/task_linux_${ARCHITECTURE}.tar.gz" \
  --output "task-linux-${ARCHITECTURE}.tar.gz"

tar --gzip --extract --file "task-linux-${ARCHITECTURE}.tar.gz" task completion/zsh/_task

install --owner=vscode --group=vscode --mode=775 "task" "/usr/local/bin/task"

install --owner=vscode --group=vscode --mode=775 completion/zsh/_task /usr/local/share/zsh/site-functions/_task

rm --recursive --force "task-linux-${ARCHITECTURE}.tar.gz" task completion
