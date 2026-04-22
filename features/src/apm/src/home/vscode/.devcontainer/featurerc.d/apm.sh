#!/usr/bin/env bash

APM_INSTALLED_FLAG="/home/vscode/.devcontainer/.apm-packages-installed"

if [ ! -f "${APM_INSTALLED_FLAG}" ]; then
  if [ -f "apm.yml" ]; then
    if apm install; then
      touch "${APM_INSTALLED_FLAG}"
    fi
  fi
fi
