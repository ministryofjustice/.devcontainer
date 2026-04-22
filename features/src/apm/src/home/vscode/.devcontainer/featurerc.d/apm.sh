#!/usr/bin/env bash

APM_INSTALLED_FLAG="/home/vscode/.devcontainer/.apm-packages-installed"

if [ ! -f "${APM_INSTALLED_FLAG}" ]; then
  if [ -f "apm.yml" ]; then
    apm install
  fi
  touch "${APM_INSTALLED_FLAG}"
fi
