#!/usr/bin/env bash
# shellcheck disable=SC2016

PROMPT+='`\
  CURRENT_CONTEXT=$(kubectl config current-context 2>/dev/null); \
  CURRENT_NAMESPACE=$(kubectl config view --minify --output "jsonpath={..namespace}" 2>/dev/null); \
  case ${CURRENT_CONTEXT} in \
    *"development"*|*"sandbox"*) \
      colour=green \
      ;; \
    *"test"*) \
      colour=blue \
      ;; \
    *"preproduction"*) \
      colour=yellow \
      ;; \
    *"production"*) \
      colour=red \
      ;; \
    *) \
      colour=white \
      ;; \
  esac; \
  if [[ ! -z ${CURRENT_CONTEXT} ]]; then \
    echo -n "[ context: %{$fg[$colour]%}${CURRENT_CONTEXT}%{$reset_color%} ] "; \
  fi; \
  if [[ ! -z ${CURRENT_NAMESPACE} ]]; then \
    echo -n "[ namespace: ${CURRENT_NAMESPACE} ] "; \
  fi
`'
