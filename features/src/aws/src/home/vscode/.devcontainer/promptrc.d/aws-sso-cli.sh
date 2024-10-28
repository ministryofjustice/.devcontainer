#!/usr/bin/env bash
# shellcheck disable=SC2016

PROMPT+='`\
  case ${AWS_SSO_PROFILE} in \
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
  if [[ ! -z ${AWS_SSO_PROFILE} ]]; then \
    echo -n "[ aws: %{$fg[$colour]%}${AWS_SSO_PROFILE}@${AWS_DEFAULT_REGION}%{$reset_color%} ] "; \
  fi
`'
