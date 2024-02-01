#!/usr/bin/env bash
# shellcheck disable=SC2016

PROMPT+='`\
  kubectlCurrentContext=$(kubectl config current-context 2>/dev/null); \
  kubectlCurrentNamespace=$(kubectl config view --minify --output "jsonpath={..namespace}"); \
  kubectlClientId=$(kubectl config view --output json | jq -r ".users[0].user[\"auth-provider\"].config[\"client-id\"]"); \
  kubectlServerVersion=$(kubectl version --output json 2>/dev/null | jq -r .serverVersion.gitVersion | sed "s/v//"); \
  && if [[ "${kubectlCurrentContext}" == "cloud-platform-live" ]] && [[ "${kubectlClientId}" == "REPLACE_WITH_CLIENT_ID" ]]; then \
    echo -n "[ cluster: %{$fg[yellow]%}${kubectlCurrentContext} (requires authentication)%{$reset_color%} ] "; \
  elif [[ "${kubectlCurrentContext}" == "cloud-platform-live" ]] && [[ ! -z "${kubectlServerVersion}" ]]; then \
    echo -n "[ cluster: %{$fg[green]%}${kubectlCurrentContext} (authenticated)%{$reset_color%} ] "; \
  else
    echo -n "[ cluster: %{$fg[red]%}${kubectlCurrentContext} (issue with authentication)%{$reset_color%} ] "; \
  fi \
  && if [[ "${kubectlCurrentContext}" == "cloud-platform-live" ]] && [[ ! -z "${kubectlCurrentNamespace}" ]] && [[ "${kubectlCurrentNamespace}" == *"-prod"* ]]; then \
    echo -n "[ namespace: %{$fg[red]%}${kubectlCurrentNamespace}%{$reset_color%} ] "; \
  elif [[ "${kubectlCurrentContext}" == "cloud-platform-live" ]] && [[ ! -z "${kubectlCurrentNamespace}" ]]; then \
    echo -n "[ namespace: %{$fg[green]%}${kubectlCurrentNamespace}%{$reset_color%} ] "; \
  fi \
`'
