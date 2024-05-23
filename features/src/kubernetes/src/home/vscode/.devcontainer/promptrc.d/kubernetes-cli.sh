#!/usr/bin/env bash
# shellcheck disable=SC2016

PROMPT+='`\
  export KUBE_CURRENT_CONTEXT=$(kubectl config current-context 2>/dev/null); \
  export KUBE_CURRENT_NAMESPACE=$(kubectl config view --minify --output "jsonpath={..namespace}"); \
  if [[ "${KUBE_CURRENT_CONTEXT}" == *"development"* ]]; then \
    echo -n "[ context: %{$fg[green]%}${KUBE_CURRENT_CONTEXT}%{$reset_color%} ] "; \
  elif [[ "${KUBE_CURRENT_CONTEXT}" == *"production"* ]]; then \
    echo -n "[ context: %{$fg[red]%}${KUBE_CURRENT_CONTEXT}%{$reset_color%} ] "; \
  else [[ -z "${KUBE_CURRENT_CONTEXT}" ]]; then \
    echo -n "[ context: %{$fg[blue]%}${KUBE_CURRENT_CONTEXT}%{$reset_color%} ] "; \
  fi \
  && if [[ ! -z "${KUBE_CURRENT_NAMESPACE}" ]]; then \
    echo -n "[ namespace: %{$fg[white]%}${KUBE_CURRENT_NAMESPACE}%{$reset_color%} ] "; \
  fi \
`'
