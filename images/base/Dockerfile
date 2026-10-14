#checkov:skip=CKV_DOCKER_2: HEALTHCHECK not required - This image is supervised by VS Code's Remote Containers extension
#checkov:skip=CKV_DOCKER_3: USER not required - A non-root user is created, and used by VS Code's Remote Containers extension
# hadolint global ignore=DL3008,DL3013

FROM mcr.microsoft.com/devcontainers/base:3.0.10-ubuntu24.04@sha256:21e9e3275736cb3bc33a2904b279a2ab292c51fedd53c2963463627d4586c3e6

LABEL org.opencontainers.image.vendor="Ministry of Justice" \
      org.opencontainers.image.authors="Dev Container Community" \
      org.opencontainers.image.title="Base Image" \
      org.opencontainers.image.description="Extension of Microsoft's image" \
      org.opencontainers.image.url="https://github.com/ministryofjustice/.devcontainer/images/base"

SHELL ["/bin/bash", "-e", "-u", "-o", "pipefail", "-c"]

COPY --chown=root:root --chmod=0644 src/usr/local/share/ca-certificates/moj-root.crt /usr/local/share/ca-certificates/moj-root.crt
COPY --chown=nobody:nobody --chmod=0755 src/usr/local/bin/devcontainer-utils /usr/local/bin/devcontainer-utils
COPY --chown=nobody:nobody --chmod=0444 src/usr/local/etc/vscode-dev-containers/first-run-notice.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt
COPY --chown=vscode:vscode --chmod=0755 src/home/vscode/.zshrc.snippet /home/vscode/.zshrc.snippet
COPY --chown=vscode:vscode --chmod=0755 src/home/vscode/.oh-my-zsh/custom/themes/devcontainers.zsh-theme /home/vscode/.oh-my-zsh/custom/themes/devcontainers.zsh-theme

RUN <<EOF

update-ca-certificates

apt-get update --yes

apt-get upgrade --yes

apt-get install --yes \
  python3-pip

apt-get clean --yes

rm --force --recursive /var/lib/apt/lists/*

chsh --shell "$(which zsh)" vscode

cat /home/vscode/.zshrc.snippet >> /home/vscode/.zshrc

rm --force /home/vscode/.zshrc.snippet

install --directory --owner=vscode --group=vscode /home/vscode/.devcontainer

install --directory --owner=vscode --group=vscode /home/vscode/.devcontainer/featurerc.d

install --directory --owner=vscode --group=vscode /home/vscode/.devcontainer/promptrc.d

install --directory --owner=vscode --group=vscode /home/vscode/.dotfiles
EOF


ONBUILD RUN <<EOF
apt-get update --yes

apt-get upgrade --yes

apt-get clean --yes

rm --force --recursive /var/lib/apt/lists/*
EOF
