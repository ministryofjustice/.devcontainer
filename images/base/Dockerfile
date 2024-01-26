FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

LABEL org.opencontainers.image.vendor="Ministry of Justice" \
      org.opencontainers.image.authors="Dev Container Community" \
      org.opencontainers.image.title="Base Image" \
      org.opencontainers.image.description="Extended version of Microsoft's image" \
      org.opencontainers.image.url="https://github.com/ministryofjustice/data-platform/tree/main/containers/actions-runner"

COPY --chown=nobody:nobody --chmod=0755 src/usr/local/bin/devcontainer-utils /usr/local/bin/devcontainer-utils
COPY --chown=nobody:nobody --chmod=0444 src/usr/local/etc/vscode-dev-containers/first-run-notice.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt
COPY --chown=vscode:vscode --chmod=0755 src/home/vscode/.oh-my-zsh/custom/themes/devcontainers.zsh-theme /home/vscode/.oh-my-zsh/custom/themes/devcontainers.zsh-theme

RUN apt-get update --yes \
    && apt-get upgrade --yes \
    && apt-get clean --yes \
    && rm -rf /var/lib/apt/lists/* \
    && chsh --shell "$(which zsh)" vscode \
    && install --directory --owner=vscode --group=vscode /home/vscode/.devcontainer \
    && install --directory --owner=vscode --group=vscode /home/vscode/.devcontainer/featurerc.d \
    && install --directory --owner=vscode --group=vscode /home/vscode/.devcontainer/promptrc.d

RUN cat <<EOF >> /home/vscode/.zshrc

# dev container feature completion scripts
if [ "\$(ls -A /home/vscode/.devcontainer/featurerc.d)" ]; then
  for file in /home/vscode/.devcontainer/featurerc.d/*.sh; do
    source "\${file}"
  done
fi

EOF

ONBUILD RUN apt-get update --yes \
            && apt-get upgrade --yes \
            && apt-get clean --yes \
            && rm -rf /var/lib/apt/lists/*
