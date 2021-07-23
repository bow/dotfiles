# load own copy of .git-completion.bash if it exists
if [ -f ~/.git-completion.bash ]; then
    # shellcheck source=.git-completion.bash
    source ~/.git-completion.bash
fi

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)

gpg-connect-agent updatestartuptty /bye >/dev/null
