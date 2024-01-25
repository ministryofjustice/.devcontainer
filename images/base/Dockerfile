FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

LABEL org.opencontainers.image.vendor="Ministry of Justice" \
      org.opencontainers.image.authors="Dev Container Community" \
      org.opencontainers.image.title="Base Image" \
      org.opencontainers.image.description="Extended version of Microsoft's image" \
      org.opencontainers.image.url="https://github.com/ministryofjustice/data-platform/tree/main/containers/actions-runner"

COPY --chown=nobody:nobody --chmod=0755 src/usr/local/bin/devcontainer-utils /usr/local/bin/devcontainer-utils
