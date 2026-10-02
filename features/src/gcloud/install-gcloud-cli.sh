#!/usr/bin/env bash

set -e

VERSION="${GCLOUDCLIVERSION:-latest}"

install --directory --mode=0755 /usr/share/keyrings
curl --fail-with-body --location --silent --show-error https://packages.cloud.google.com/apt/doc/apt-key.gpg |
  gpg --dearmor --yes --output /usr/share/keyrings/cloud.google.gpg

printf '%s\n' 'deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main' \
  >/etc/apt/sources.list.d/google-cloud-sdk.list

apt-get update
if [[ "${VERSION}" == "latest" ]]; then
  apt-get install --yes google-cloud-cli
else
  if [[ "${VERSION}" != *-* ]]; then
    VERSION="${VERSION}-0"
  fi
  apt-get install --yes "google-cloud-cli=${VERSION}"
fi
rm --recursive --force /var/lib/apt/lists/*
