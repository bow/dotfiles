#!/usr/bin/env bash

# shellcheck source=/dev/null
[ -f ~/.bashrc ] && [ ! -f ~/.bash_profile ] && . ~/.bashrc

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  export SSH_AUTH_SOCK
fi
GPG_TTY=$(tty)
export GPG_TTY

gpg-connect-agent updatestartuptty /bye >/dev/null
