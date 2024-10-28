#!/usr/bin/env bash
# shellcheck disable=SC2016

# Logic for authentication check is:
# Check context is "cloud-platform-live" and client-id is "REPLACE_WITH_CLIENT_ID", then you aren't authenticated
# Check context is "cloud-platform-live" and client-id is not "REPLACE_WITH_CLIENT_ID" and server version is returned, then you are authenticated
# Check context is "cloud-platform-live" and client-id is not "REPLACE_WITH_CLIENT_ID" and server version is null, then there is a potential issue with authentication

PROMPT+='`\
  CURRENT_CONTEXT=$(kubectl config current-context 2>/dev/null); \
  CURRENT_NAMESPACE=$(kubectl config view --minify --output "jsonpath={..namespace}" 2>/dev/null); \
  CURRENT_CLIENT_ID=$(kubectl config view --output json | jq -r ".users[0].user[\"auth-provider\"].config[\"client-id\"]"); \
  SERVER_VERSION=$(kubectl version --output json 2>/dev/null | jq -r .serverVersion.gitVersion); \
  if [[ "${CURRENT_CONTEXT}" == "cloud-platform-live" ]] && [[ "${CURRENT_CLIENT_ID}" == "REPLACE_WITH_CLIENT_ID" ]]; then \
    echo -n "[ cluster: %{$fg[yellow]%}${CURRENT_CONTEXT} (requires authentication)%{$reset_color%} ] "; \
  elif [[ "${CURRENT_CONTEXT}" == "cloud-platform-live" ]] && [[ "${CURRENT_CLIENT_ID}" != "REPLACE_WITH_CLIENT_ID" ]] && [[ "${SERVER_VERSION}" != "null" ]]; then \
    echo -n "[ cluster: %{$fg[green]%}${CURRENT_CONTEXT} (authenticated)%{$reset_color%} ] "; \
  elif [[ "${CURRENT_CONTEXT}" == "cloud-platform-live" ]] && [[ "${CURRENT_CLIENT_ID}" != "REPLACE_WITH_CLIENT_ID" ]] && [[ "${SERVER_VERSION}" == "null" ]]; then
    echo -n "[ cluster: %{$fg[red]%}${CURRENT_CONTEXT} (issue with authentication)%{$reset_color%} ] "; \
  fi; \
  case ${CURRENT_NAMESPACE} in \
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
  if [[ ! -z ${CURRENT_NAMESPACE} ]]; then \
    echo -n "[ namespace: %{$fg[$colour]%}${CURRENT_NAMESPACE}%{$reset_color%} ] "; \
  fi
`'
