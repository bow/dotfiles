# .bashrc
# Wibowo Arindrarto  <contact@arindrarto.dev>

# check if bash is running interactively
[ -z "$PS1" ] && return

# check if we have starship and use result to decide how to build prompt
starship_exists=0
if command -v starship 1>/dev/null 2>&1; then
    starship_exists=1
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
    echo -en "\e]P0111111" # black
    echo -en "\e]P8111111" # darkgrey
    echo -en "\e]P1803232" # darkred
    echo -en "\e]P9c43232" # red
    echo -en "\e]P23d762f" # darkgreen
    echo -en "\e]PA5ab23a" # green
    echo -en "\e]P3aa9943" # brown
    echo -en "\e]PBefef60" # yellow
    echo -en "\e]P427528e" # darkblue
    echo -en "\e]PC4388e1" # blue
    echo -en "\e]P5706c9a" # darkmagenta
    echo -en "\e]PDa07de7" # magenta
    echo -en "\e]P65da5a5" # darkcyan
    echo -en "\e]PE98e1e1" # cyan
    echo -en "\e]P7d0d0d0" # lightgrey
    echo -en "\e]PFffffff" # white
    clear                  # for background artifacting
elif command -v alacritty 1>/dev/null 2>&1; then
    export TERM=alacritty
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

# define custom PS1 if starship does not exist
if [[ "${starship_exists}" -eq 0 ]]; then
    # load own copy of .git-prompt.sh if it exists
    if [ -f ~/.git-prompt.sh ]; then
        # shellcheck source=.git-prompt.sh
        source ~/.git-prompt.sh
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

    function get_git_stat {
        export GIT_PS1_SHOWSTASHSTATE=true
        export GIT_PS1_SHOWDIRTYSTATE=true
        export GIT_PS1_SHOWUNTRACKEDFILES=true
        export GIT_PS1_SHOWUPSTREAM="verbose"
        nick=$(__git_ps1 "(  %s) ")
        [[ -n "$nick" ]] && echo "$nick"
        return 0
    }

    function set_prompt {
        pyenv_name=$(pyenv version-name 2> /dev/null || true)
        venv_name="" && [ "${pyenv_name}" != "" ] && [ "${pyenv_name}" != "system" ] && venv_name="\[${green}\] ${pyenv_name} \[${nocol}\]"
        asdf_active=$(asdf current 2>&1 | grep -vP " system " > /dev/null && echo "ok" || true)
        asdf_indicator="" && [ "${asdf_active}" != "" ] && asdf_indicator="\[${green}\]  \[${nocol}\]"
        PS1="\n${nocol}\`if [ \$? = 0 ]; then echo ${blue}; else echo ${red}; fi\`\[${nocol}\] \[${blue}\]\u@\h\[${nocol}\] ${asdf_indicator}${venv_name}\[${grey}\]$(get_git_stat)\[${nocol}\]\[${yellow}\]\w\[${nocol}\]\n\$ "
    }

    PROMPT_COMMAND=set_prompt
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set default text editor
if command -v nvim 1>/dev/null 2>&1; then
    export EDITOR="nvim"
elif command -v vim 1>/dev/null 2>&1; then
    export EDITOR="vim"
else
    export EDITOR="vi"
fi

# aliases
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
alias grest='history | grep'            # grep history
alias chmox='chmod +x'                  # set user-executable bit
alias unix-ns='date +%s%9N'             # nanoseconds timestamp

alias ccat='pygmentize -g -O style=gruvbox-dark,linenos=1'  # colorized cat
alias clip='xargs echo -n | xclip -selection c'             # copy to X clipboard, trimming newline

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

# resolve path and copy it to clipboard
function pcp() {
    target=$(readlink -f "${1:-.}")
    (echo ${target} | xargs echo -n | xclip -selection c) \
        && echo "${target}"
}

# sudo and then immediately forget cache
function sudok() { sudo "$@"; sudo -k; }

# calculator
function calc() { echo "$*" | bc; }

# helper for creating and activating new pyenv virtualenvs
function mkpyenv() {
    py_version=${2:-3.11.0}
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

# set 'open' handlers from shell
if command -v handlr 1>/dev/null 2>&1; then
    function open() { handlr open ${1:-.}; }
    alias o='open'
elif command -v xdg-open 1>/dev/null 2>&1; then
    function open() { xdg-open 1>/dev/null 2>&1 ${1:-.}; }
    alias o='open'
fi

# set __pycache__ out of source trees
case "${OSTYPE}" in
    linux-*)
        dir="${HOME}/.cache/python/pycache"
        if [ ! -d "${dir}" ]; then
            mkdir -p "${dir}"
        fi
        export PYTHONPYCACHEPREFIX="${dir}"
        ;;
    darwin*)
        dir="${HOME}/Library/Caches/python/pycache"
        if [ ! -d "${dir}" ]; then
            mkdir -p "${dir}"
        fi
        export PYTHONPYCACHEPREFIX="${dir}"
        ;;
    *)
        ;;
esac

# load private settings if it exists
if [ -f ~/.bash_private ]; then
    # shellcheck source=.git-prompt.sh
    source ~/.bash_private
fi

# autojump config
if command -v autojump 1>/dev/null 2>/dev/null && test -f /etc/profile.d/autojump.bash; then
    . /etc/profile.d/autojump.bash
fi

# .local/bin config
case ":${PATH}:" in
    *:"${HOME}/.local/bin":*)
        ;;
    *)
        export PATH="${HOME}/.local/bin:${PATH}"
        ;;
esac

# basher config
case ":${PATH}:" in
    *:"${HOME}/.basher/bin":*)
        ;;
    *)
        export PATH="${HOME}/.basher/bin:${PATH}"
        ;;
esac
if command -v basher 1>/dev/null 2>&1; then
    eval "$(basher init -)"
fi

# asdf config
if [ -f /opt/asdf-vm/asdf.sh ]; then
    # shellcheck source=/opt/asdf-vm/asdf.sh
    source /opt/asdf-vm/asdf.sh
    # shellcheck source=$HOME/.asdf/plugins/java/set-java-home.bash
    if [ -f "$HOME/.asdf/plugins/java/set-java-home.bash" ]; then
        source "$HOME/.asdf/plugins/java/set-java-home.bash"
    fi
fi

# pyenv config
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="${HOME}/.pyenv"
case ":${PATH}:" in
    *:"${PYENV_ROOT}/shims":*)
        ;;
    *)
        export PATH="${PYENV_ROOT}/shims:${PATH}"
        ;;
esac
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path -)"
    eval "$(pyenv virtualenv-init -)"
fi

# nodenv config
export NODENV_ROOT="${HOME}/.nodenv"
case ":${PATH}:" in
    *:"${NODENV_ROOT}/bin":*)
        ;;
    *)
        export PATH="${NODENV_ROOT}/bin:${PATH}"
        ;;
esac
if command -v nodenv 1>/dev/null 2>&1; then
    eval "$(nodenv init -)"
fi

# direnv config
if command -v direnv 1>/dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi

# starship config
if [[ "${starship_exists}" -eq 1 ]]; then
    eval "$(starship init bash)"
fi
function set_window_title(){
    echo -ne "\033]0; $(echo "Terminal ${PWD/#$HOME/'~'}") \007"
}
starship_precmd_user_func="set_window_title"

# optional terraform completion.
if command -v terraform 1>/dev/null 2>&1; then
    alias tf="terraform"
    path="$(which terraform)"
    complete -C ${path} terraform
    complete -C ${path} tf
fi
