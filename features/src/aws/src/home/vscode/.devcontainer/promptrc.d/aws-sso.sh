#!/usr/bin/env bash

PROMPT+='`\
  if [[ ${AWS_SSO_PROFILE} == *"development"* || ${AWS_SSO_PROFILE} == *"test"* ]]; then \
    echo -n "[ aws: %{$fg[green]%}${AWS_SSO_PROFILE}@${AWS_DEFAULT_REGION}%{$reset_color%} ] "; \
  elif [[ ${AWS_SSO_PROFILE} == *"preproduction"* ]]; then \
    echo -n "[ aws: %{$fg[yellow]%}${AWS_SSO_PROFILE}@${AWS_DEFAULT_REGION}%{$reset_color%} ] "; \
  elif [[ ${AWS_SSO_PROFILE} == *"production"* ]]; then \
    echo -n "[ aws: %{$fg[red]%}${AWS_SSO_PROFILE}@${AWS_DEFAULT_REGION}%{$reset_color%} ] "; \
  elif [[ ! -z ${AWS_SSO_PROFILE} ]]; then \
    echo -n "[ aws: %{$fg[blue]%}${AWS_SSO_PROFILE}@${AWS_DEFAULT_REGION}%{$reset_color%} ] "; \
  fi \
`'
