#checkov:skip=CKV_DOCKER_2: HEALTHCHECK not required - This image is supervised by VS Code's Remote Containers extension
#checkov:skip=CKV_DOCKER_3: USER not required - A non-root user is created, and used by VS Code's Remote Containers extension
# hadolint global ignore=DL3008,DL3013

FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

LABEL org.opencontainers.image.vendor="Ministry of Justice" \
      org.opencontainers.image.authors="Dev Container Community" \
      org.opencontainers.image.title="Base Image" \
      org.opencontainers.image.description="Extended version of Microsoft's image" \
      org.opencontainers.image.url="https://github.com/ministryofjustice/.devcontainer/images/base"

COPY --chown=nobody:nobody --chmod=0755 src/usr/local/bin/devcontainer-utils /usr/local/bin/devcontainer-utils
COPY --chown=nobody:nobody --chmod=0444 src/usr/local/etc/vscode-dev-containers/first-run-notice.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt
COPY --chown=vscode:vscode --chmod=0755 src/home/vscode/.oh-my-zsh/custom/themes/devcontainers.zsh-theme /home/vscode/.oh-my-zsh/custom/themes/devcontainers.zsh-theme

RUN apt-get update --yes \
    && apt-get upgrade --yes \
    && apt-get install --yes --no-install-recommends \
         python3-pip \
    && apt-get clean --yes \
    && rm --force --recursive /var/lib/apt/lists/* \
    && python3 -m pip install --no-cache-dir --upgrade \
         pip \
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
            && rm --force --recursive /var/lib/apt/lists/* \
            && python3 -m pip install --no-cache-dir --upgrade \
                 pip
