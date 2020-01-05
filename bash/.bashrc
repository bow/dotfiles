# .bashrc
# Wibowo Arindrarto  <bow@bow.web.id>

# check if bash is running interactively
[ -z "$PS1" ] && return

# load own copy of .git-prompt.sh if it exists
if [ -f ~/.git-prompt.sh ]; then
    # shellcheck source=.git-prompt.sh
    source ~/.git-prompt.sh
fi

# load own copy of .git-completion.bash if it exists
if [ -f ~/.git-completion.bash ]; then
    # shellcheck source=.git-completion.bash
    source ~/.git-completion.bash
fi

# load own copy of .kubectl-completion.bash if it exists
if [ -f ~/.kubectl-completion.bash ]; then
    # shellcheck source=.kubectl-completion.bash
    source ~/.kubectl-completion.bash
fi

# load own copy of .kube-ps1.bash if it exists
if [ -f ~/.kube-ps1.bash ]; then
    # shellcheck source=.kube-ps1.bash
    source ~/.kube-ps1.bash
fi
KUBE_PS1_SEPARATOR=""
KUBE_PS1_PREFIX=""
KUBE_PS1_SUFFIX=" "
KUBE_PS1_SYMBOL_COLOR=magenta
KUBE_PS1_CTX_COLOR=magenta
KUBE_PS1_NS_COLOR=magenta

# load own copy of .minikube-completion.bash if it exists
if [ -f ~/.minikube-completion.bash ]; then
    # shellcheck source=.minikube-completion.bash
    source ~/.minikube-completion.bash
fi

# prevent cluttering history with dup lines
HISTCONTROL=ignoredups:ignorespace

# append to the history file instead of overwriting it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# color & ui
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0111111" #black
    echo -en "\e]P8111111" #darkgrey
    echo -en "\e]P1803232" #darkred
    echo -en "\e]P9c43232" #red
    echo -en "\e]P23d762f" #darkgreen
    echo -en "\e]PA5ab23a" #green
    echo -en "\e]P3aa9943" #brown
    echo -en "\e]PBefef60" #yellow
    echo -en "\e]P427528e" #darkblue
    echo -en "\e]PC4388e1" #blue
    echo -en "\e]P5706c9a" #darkmagenta
    echo -en "\e]PDa07de7" #magenta
    echo -en "\e]P65da5a5" #darkcyan
    echo -en "\e]PE98e1e1" #cyan
    echo -en "\e]P7d0d0d0" #lightgrey
    echo -en "\e]PFffffff" #white
#   clear #for background artifacting
else
    export TERM=xterm-256color
fi

# set .dircolors
if [ -e /bin/dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
fi

# set prompt
nocol='\033[0m'
red='\033[31m'
green='\033[32m'
yellow='\033[33m'
blue='\033[34m'
purple='\033[35m'
cyan='\033[36m'
grey='\033[37m'

function set_prompt {
    pyenv_name=$(pyenv version-name 2> /dev/null || true)
    venv_name="" && [ "${pyenv_name}" != "" ] && [ "${pyenv_name}" != "system" ] && venv_name="\[${green}\] ${pyenv_name} \[${nocol}\]"
    nodenv_name=$(nodenv version-name 2> /dev/null || true)
    nvenv_name="" && [ "${nodenv_name}" != "" ] && [ "${nodenv_name}" != "system" ] && nvenv_name="\[${green}\] ${nodenv_name} \[${nocol}\]"
    PS1="\n${nocol}\`if [ \$? = 0 ]; then echo ${blue}; else echo ${red}; fi\`\[${nocol}\] \[${blue}\]\u@\h\[${nocol}\] ${venv_name}${nvenv_name}$(kube_ps1)\[${grey}\]$(get_git_stat)\[${nocol}\]\[${yellow}\]\w\[${nocol}\]\n\$ "
}

PROMPT_COMMAND=set_prompt

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set default text editor
export EDITOR="vim"

# aliases
alias ccat='pygmentize -g -O style=colorful,linenos=1'
alias ls='ls -F --color=auto'           # colorize
alias less='less -SN'                   # no wraps and include line numbers
alias grep='grep --color=auto'          # colorize
alias lname='ls -alF'                   # sort by name
alias lnames='ls -A'                    # sort by name, short
alias lsize='ls -lSrh'                  # sort by size
alias ltime='ls -ltrh'                  # sort by mtime
alias lext='ls -lXBh'                   # sort by extension
alias df='df -h -T --total'             # human-readable output
alias du='du -sh'                       # ditto
alias mkdir='mkdir -p'                  # create parents by default
alias cp='cp -iv'                       # interactive + verbose by default
alias mv='mv -i'                        # interactive by default
alias rm='rm -i'                        # interactive by default
alias reload='source ~/.bashrc'         # reload .bashrc
alias grest='history | grep'
alias chmox='chmod +x'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias xclip='xargs echo -n | xclip -selection c'        # copy to X clipboard, trimming newline
alias unix-ns='date +%s%9N'

# Docker aliases
# Modified from: https://github.com/tcnksm/docker-alias/blob/master/zshrc
# list container process
alias dps="docker ps"
# list process included stop container
alias dpsa="docker ps -a"
# list images
alias dlsi="docker images"
# list volumes
alias dlsv="docker volume ls"
# list networks
alias dlsn="docker network ls"
# run daemonized container, e.g., $drnd base /bin/echo hello
alias drnd="docker run -dP"
# run interactive container, e.g., $drni base /bin/bash
alias drni="docker run --rm -itP"
# execute interactive container, e.g., $dex base /bin/bash
function dexi() { docker exec -it "${1}" "${2:-/bin/bash}"; }
# remove exited containers
function drm() { docker rm $(docker ps -qf 'status=exited'); }
# remove dangling images
function drmi() { docker rmi $(docker images -qf 'dangling=true'); }
# shell into running container
function dsh() { docker exec -it "$(docker ps -aqf 'name=$1')" "${2:-sh}"; }
# dockerfile build, e.g., $dbu tcnksm/test
function dbu() { docker build -t="$1" .; }

# create dir and cd into it
function mkcd() { command mkdir -p "$1" && cd "$1"; }

# change owner to current user
function mkmine() { sudo chown -R "${USER}" "${1:-.}"; }

# calculator
function calc() { echo "$*" | bc; }

# helper for creating and activating new pyenv virtualenvs
function mkpyenv() {
    py_version=${2:-3.8.1}
    env_name=$1
    pyenv virtualenv "${py_version}" "${env_name}" \
        && printf "%s\n%s\n" "${env_name}" "${py_version}" \
        > .python-version \
        && pip install --upgrade pip
}

# mount iso images
function mountiso() {
    if [ ! "$1" ]; then
        echo "ERROR: missing iso image argument"
        return
    fi
    mountdir="/media/${1%.iso}"
    if [ ! -d "{mountdir}" ]; then
        sudo 'mkdir' '-p' "${mountdir}"
    fi
    sudo mount -o loop "$1" "$mountdir"
}

# unmount iso images
function umountiso() {
    if [ -d "$1" ]; then
        sudo umount "$1"
        sudo rmdir "$1"
    else
        echo "ERROR: mount directory not found"
        return
    fi
}

# pack directories
function pack() {
    target=${2%/}
    case $1 in
    gz)
        tar czvf "${target}.tar.gz" "${target}" ;;
    bz)
        tar cjvf "${target}.tar.bz2" "${target}" ;;
    xz)
        tar cJvf "${target}.tar.xz" "${target}" ;;
    7z)
        7zr a "${target}.7z" "${target}" ;;
    rar)
        rar a "${target}.rar" "${target}" ;;
    zip)
        zip -r "${target}.zip" "${target}" ;;
    *)
        echo "Usage: pack [gzip|bzip2|xz|7z|rar|zip] [target]" ;;
    esac
}

# unpack directories
function unpack() {
    case $1 in
    *.tar.gz | *.tgz | *.tar.bz2 | *.tbz2 | *.tar.xz | *.txz)
        tar xfv "$1" ;;
    *.7z)
        7zr x "$1" ;;
    *.rar)
        unrar x "$1" ;;
    *.zip)
        unzip "$1" ;;
    *)
        echo "Usage: unpack [target]" ;;
    esac
}

# check weather from wego
function wttr() {
    curl http://wttr.in/"${1:-Copenhagen}"
}

# controls git prompt and its color
function get_git_stat {
  export GIT_PS1_SHOWSTASHSTATE=true
  export GIT_PS1_SHOWDIRTYSTATE=true
  export GIT_PS1_SHOWUNTRACKEDFILES=true
  export GIT_PS1_SHOWUPSTREAM="verbose"
  nick=$(__git_ps1 "(⎇  %s) ")
  [[ -n "$nick" ]] && echo "$nick"
  return 0
}

# load private settings if it exists
if [ -f ~/.bash_private ]; then
    # shellcheck source=.git-prompt.sh
    source ~/.bash_private
fi

# basher config
export PATH="${HOME}/.basher/bin:${PATH}"
if command -v basher 1>/dev/null 2>&1; then
    eval "$(basher init -)"
fi

# pyenv config
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# nodenv config
export NODENV_ROOT="${HOME}/.nodenv"
export PATH="${NODENV_ROOT}/bin:${PATH}"
if command -v nodenv 1>/dev/null 2>&1; then
    eval "$(nodenv init -)"
fi

# direnv config
if command -v direnv 1>/dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi

# ssh-agent config
SSH_AGENT_ENV="${HOME}/.ssh/.agent.env"
if [ -f "${SSH_AGENT_ENV}" ] ; then
    . "${SSH_AGENT_ENV}" > /dev/null
    if ! kill -0 "${SSH_AGENT_PID}" > /dev/null 2>&1; then
        echo "stale agent file found - spawning new agent ..."
        eval $(ssh-agent | tee "${SSH_AGENT_ENV}")
        ssh-add
    fi
else
    eval $(ssh-agent | tee "${SSH_AGENT_ENV}")
    ssh-add
fi
