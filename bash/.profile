#!/usr/bin/env bash

# local bin configs
case ":${PATH}:" in
    *:"${HOME}/local/bin":*)
        ;;
    *)
        export PATH="${HOME}/local/bin:${PATH}"
        ;;
esac
case ":${PATH}:" in
    *:"${HOME}/.cargo/bin":*)
        ;;
    *)
        export PATH="${HOME}/.cargo/bin:${PATH}"
        ;;
esac

# load own copy of .git-completion.bash if it exists
# shellcheck source=/dev/null
test -f "${HOME}/.git-completion.bash" && . "${HOME}/.git-completion.bash"

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  export SSH_AUTH_SOCK
fi
GPG_TTY=$(tty)
export GPG_TTY

gpg-connect-agent updatestartuptty /bye >/dev/null
