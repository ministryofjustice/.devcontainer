#!/usr/bin/env bash
# shellcheck disable=SC2016

PROMPT+='`\
  case ${AWS_SSO_PROFILE} in \
    *"development"*|*"sandbox"*) \
      color=green \
      ;; \
    *"test"*) \
      color=blue \
      ;; \
    *"preproduction"*) \
      color=yellow \
      ;; \
    *"production"*) \
      color=red \
      ;; \
    *) \
      color=white \
      ;; \
  esac; \
  if [[ ! -z ${AWS_SSO_PROFILE} ]]; then \
    echo -n "[ aws: %{$fg[$color]%}${AWS_SSO_PROFILE}@${AWS_DEFAULT_REGION}%{$reset_color%} ] "; \
  fi
`'
