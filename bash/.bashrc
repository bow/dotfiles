#!/usr/bin/env bash

# .bashrc
# Wibowo Arindrarto  <contact@arindrarto.dev>

# check if bash is running interactively
[ -z "$PS1" ] && return

# helper function to check if executable exists
function has_exe() { [[ -n "${1}" ]] && command -v "${1}" 1>/dev/null 2>&1; }

# check if we have starship and use result to decide how to build prompt
starship_exists=0
if has_exe starship; then
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
if [[ "$TERM" == "linux" ]]; then
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
else
    export TERM=xterm-256color
fi

# set .dircolors
[[ -e /bin/dircolors ]] && eval "$(dircolors -b ~/.dircolors)"

# set prompt
# shellcheck disable=SC2034
nocol='\033[0m'
# shellcheck disable=SC2034
red='\033[31m'
# shellcheck disable=SC2034
green='\033[32m'
# shellcheck disable=SC2034
yellow='\033[33m'
# shellcheck disable=SC2034
blue='\033[34m'
# shellcheck disable=SC2034
purple='\033[35m'
# shellcheck disable=SC2034
cyan='\033[36m'
# shellcheck disable=SC2034
grey='\033[37m'

# Define custom PS1 if starship does not exist or we are in console.
if [[ "${starship_exists}" -eq 0 || "${TERM}" == "linux" ]]; then
    # load own copy of .git-prompt.sh if it exists
    # shellcheck source=/dev/null
    [[ -f "${HOME}/.git-prompt.sh" ]] && . "${HOME}/.git-prompt.sh"

    function get_git_stat {
        if has_exe __git_ps1; then
            export GIT_PS1_SHOWSTASHSTATE=true
            export GIT_PS1_SHOWDIRTYSTATE=true
            export GIT_PS1_SHOWUNTRACKEDFILES=true
            export GIT_PS1_SHOWUPSTREAM="verbose"
            nick=$(__git_ps1 "(  %s) ")
            [[ -n "$nick" ]] && echo "$nick"
        fi
        return 0
    }

    function set_prompt {
        PS1="\n${nocol}\`if [[ \$? -eq 0 ]]; then echo ${blue}; else echo ${red}; fi\`-\[${nocol}\] \[${blue}\]\u@\h\[${nocol}\] $(get_git_stat)\[${nocol}\]\[${yellow}\]\w\[${nocol}\]\n> "
    }

    PROMPT_COMMAND=set_prompt
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set default text editor
if has_exe nvim; then
    export EDITOR="nvim"
elif has_exe vim; then
    export EDITOR="vim"
else
    export EDITOR="vi"
fi

# set ripgreprc
if has_exe rg; then
    export RIPGREP_CONFIG_PATH=${HOME}/.ripgreprc
fi

# Aliases.
# colorize
alias ls='ls -F --color=auto'
# no wraps and include line numbers
alias less='less -SN'
# colorize
alias grep='grep --color=auto'
# sort by name
alias lname='ls -alF'
# sort by name, short
alias lnames='ls -A'
# sort by size
alias lsize='ls -lSrh'
# sort by mtime
alias ltime='ls -ltrh'
# sort by extension
alias lext='ls -lXBh'
# human-readable output
alias df='df -h -T --total'
# ditto
alias du='du -sh'
# create parents by default
alias mkdir='mkdir -p'
# interactive + verbose by default
alias cp='cp -iv'
# interactive by default
alias mv='mv -i'
# interactive by default
alias rm='rm -i'
# reload .bashrc
alias reload='source ~/.bashrc'
# grep history
alias grest='history | grep'
# set user-executable bit
alias chmox='chmod +x'
# nanoseconds timestamp
alias unix-ns='date +%s%9N'
# copy to X clipboard, trimming newline
alias clip='xargs echo -n | xclip -selection c'


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
# shellcheck disable=SC2046
function drm() { docker rm $(docker ps -qf 'status=exited'); }
# remove dangling images
# shellcheck disable=SC2046
function drmi() { docker rmi $(docker images -qf 'dangling=true'); }
# shell into running container
function dsh() { docker exec -it "$(docker ps -aqf 'name=$1')" "${2:-sh}"; }
# dockerfile build, e.g., $dbu tcnksm/test
function dbu() { docker build -t="$1" .; }

# create dir and cd into it
# shellcheck disable=SC2164
function mkcd() { command mkdir -p "$1" && cd "$1"; }

# cd into the directory in which a file is contained
function fcd() { cd "$(dirname "${1}")" || exit 1; }

# change owner to current user
function mkmine() { sudo chown -R "${USER}" "${1:-.}"; }

# resolve path and copy it to clipboard
function pcp() {
    target=$(readlink -f "${1:-.}")
    echo -n "${target}" | xclip -selection c && echo "${target}"
}

# cat file and copy it to clipboard
function pcat() {
    if [ $# -ne 1 ]; then
        echo "Usage: pcat [FILE]" >&2
        return 1
    fi
    if [[ -f "${1}" ]]; then
        if [[ $(stat -c%s "${1}") -ge 1048576 ]]; then
            echo "Error: ${1} exceeds maximum allowed size of 1 MiB"
            return 1
        else
            tee >(xargs echo -n | xclip -selection c) < "${1}"
        fi
    else
        echo "Error: ${1} not found"
        return 1
    fi
}

# open an ssh connection and run tmux
function sshx() {
    ssh "${1}" -t -- /bin/sh -c 'tmux has-session && exec tmux attach || exec tmux'
}

# sudo and then immediately forget cache
function sudok() { sudo "$@"; sudo -k; }

# make a new play directory and cd into it
function pl() {
    local name="${1}"
    test -n "${name}" || { printf "%s\n" "Error: name must be specified" 1>&2 && return 1; }
    local desktop_dir="${HOME}/dsk"
    local prefix=play
    mkcd "${desktop_dir}/${prefix}-${name}"
}

# calculator
function calc() { echo "$*" | bc; }

# helper for creating and activating new pyenv virtualenvs
function mkpyenv() {
    env_name=$1
    local_pyenv_version=$(cat "$HOME/.pyenv-version" 2> /dev/null)
    pyenv_version=${2:-${local_pyenv_version:-3.13.5}}
    pyenv virtualenv "${pyenv_version}" "${env_name}" \
        && printf "%s\n%s\n" "${env_name}" "${pyenv_version}" \
        > .python-version \
        && pip install --upgrade pip
}

# mount iso images
function mountiso() {
    if [[ ! "$1" ]]; then
        echo "ERROR: missing iso image argument"
        return
    fi
    mountdir="/media/${1%.iso}"
    [[ ! -d "{mountdir}" ]] && sudo 'mkdir' '-p' "${mountdir}"
    sudo mount -o loop "$1" "$mountdir"
}

# unmount iso images
function umountiso() {
    if [[ -d "$1" ]]; then
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
        zst | zstd)
            tar --zstd -cvf "${target}.tar.zst" "${target}" ;;
        *)
            echo "Usage: pack [gzip|bzip2|xz|7z|rar|zip|zst] [target]" ;;
    esac
}

# unpack directories
function unpack() {
    case $1 in
        *.tar.gz | *.tgz | *.tar.bz2 | *.tbz2 | *.tar.xz | *.txz | *.tar.zst | *.tzst | *.tar.zstd | *.tzstd | *.tar)
            tar xfv "$1" ;;
        *.gem)
            tar xfv "$1" ;;
        *.7z)
            7zr x "$1" ;;
        *.rar)
            unrar x "$1" ;;
        *.xz)
            unxz "$1" ;;
        *.zip)
            unzip "$1" ;;
        *.zst | *.zstd)
            zst -d "$1" ;;
        *)
            echo "Usage: unpack [target]" ;;
    esac
}

# check weather from wego
function wttr() {
    curl http://wttr.in/"${1:-Copenhagen}"
}

# open url directly in web browser
function brw() {
    python -m webbrowser -t "${1:-google.com}"
}

# get absolute path to python module
function wpymod() {
    local modname="${1}"
    python <<EOF || false
import sys
try:
    import ${modname}
except ImportError:
    print("Error: module '$1' not found")
    sys.exit(1)
print(${modname}.__file__)
EOF
}

# set wallpaper file and lock background
function setwp() {
    if has_exe magick; then
        test -z "${1}" && echo "Error: requires a path argument" && return 1
        img=$(readlink -f "${1}")
        if magick identify "${img}" 1>/dev/null 2>&1; then
            wp="${HOME}/pics/wallpaper"
            lockbg=${wp}-lock
            ln -sf "${img}" "${wp}"
            magick "${wp}" -blur 0x8 "${lockbg}"
        else
            echo "Error: ${1} is not an image"
            return 1
        fi
    else
        echo "Error: required 'magick' not found"
        return 1
    fi
}

# reset GPG and SSH agent.
function credsreset() {
    gpgconf --kill gpg-agent && eval "$(ssh-agent -s)" && . "${HOME}/.profile"
}

# set bat + rg + fzf helpers if all executables exist
if has_exe bat; then

    alias bathelp="bat --plain --language=help"
    function help() {
        "$@" --help 2>&1 | bat --plain --language=help
    }

    if has_exe rg; then
        if has_exe fzf; then
            function frg() {
                result=$(
                    rg --ignore-case --color=always --line-number --no-heading "$@" \
                    | fzf \
                        --ansi --color 'hl:-1:underline,hl+:-1:underline:reverse' \
                        --delimiter ':' \
                        --preview "bat --color=always {1} --theme='gruvbox-dark' --highlight-line {2}" \
                        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
                )
                file="${result%%:*}"
                linenumber=$(echo "${result}" | cut -d: -f2)
                if [[ -n "$file" ]]; then
                        $EDITOR +"${linenumber}" "$file"
                fi
            }
        fi
    fi
fi

# set 'open' handlers from shell
if has_exe handlr; then
    function open() { handlr open "${1:-.}"; }
    alias o='open'
elif has_exe xdg-open; then
    function open() { xdg-open 1>/dev/null 2>&1 "${1:-.}"; }
    alias o='open'
fi

# set __pycache__ out of source trees
case "${OSTYPE}" in
    linux-*)
        dir="${HOME}/.cache/python/pycache"
        [[ ! -d "${dir}" ]] && mkdir -p "${dir}"
        export PYTHONPYCACHEPREFIX="${dir}"
        ;;
    darwin*)
        dir="${HOME}/Library/Caches/python/pycache"
        [[ ! -d "${dir}" ]] && mkdir -p "${dir}"
        export PYTHONPYCACHEPREFIX="${dir}"
        ;;
    *)
        ;;
esac

# load private settings if it exists
# shellcheck source=.git-prompt.sh
[[ -f ~/.bash_private ]] && . ~/.bash_private

# zoxide config
if has_exe zoxide; then
    export _ZO_ECHO=1
    eval "$(zoxide init --cmd j bash)"
fi

# XDG_* settings
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

### > PATH-affecting config -- from least prioritized ###

# basher config
case ":${PATH}:" in
    *:"${HOME}/.basher/bin":*)
        ;;
    *)
        export PATH="${HOME}/.basher/bin:${PATH}"
        ;;
esac
if has_exe basher; then
    eval "$(basher init -)"
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
if has_exe nodenv; then
    eval "$(nodenv init -)"
fi

# ghcup config
export GHCUP_INSTALL_BASE_PREFIX=${HOME}
case ":${PATH}:" in
    *:"${GHCUP_INSTALL_BASE_PREFIX}/.ghcup/bin":*)
        ;;
    *)
        export PATH="${GHCUP_INSTALL_BASE_PREFIX}/.ghcup/bin:${PATH}"
        ;;
esac

# rbenv config
if has_exe rbenv; then
    eval "$(rbenv init -)"
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
if has_exe pyenv; then
    eval "$(pyenv init --path -)"
    if command -v pyenv-virtualenv-init 1>/dev/null 2>&1; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

# uv and uvx config
if has_exe uv; then
    eval "$(uv generate-shell-completion bash)"
fi
if has_exe uvx; then
    eval "$(uvx --generate-shell-completion bash)"
fi

# go config
export GOPATH=${HOME}/.local/go
case ":${PATH}:" in
    *:"${HOME}/.local/go/bin":*)
        ;;
    *)
        export PATH="${HOME}/.local/go/bin:${PATH}"
        ;;
esac

# cargo config
case ":${PATH}:" in
    *:"${HOME}/.cargo/bin":*)
        ;;
    *)
        export PATH="${HOME}/.cargo/bin:${PATH}"
        ;;
esac

# asdf config
if [[ -f /opt/asdf-vm/asdf.sh ]]; then
    # shellcheck source=/opt/asdf-vm/asdf.sh
    . /opt/asdf-vm/asdf.sh
    # shellcheck source=/dev/null
    if [[ -f "$HOME/.asdf/plugins/java/set-java-home.bash" ]]; then
        . "$HOME/.asdf/plugins/java/set-java-home.bash"
    fi
fi
ASDF_DATA_DIR="${HOME}/.asdf"
case ":${PATH}:" in
    *:"${ASDF_DATA_DIR}/shims":*)
        ;;
    *)
        export PATH="${ASDF_DATA_DIR}/shims:${PATH}"
        ;;
esac

# .local/bin config
case ":${PATH}:" in
    *:"${HOME}/.local/bin":*)
        ;;
    *)
        export PATH="${HOME}/.local/bin:${PATH}"
        ;;
esac

# direnv config
if has_exe direnv; then
    eval "$(direnv hook bash)"
fi

### < PATH-affecting config done ###

# starship config
if [[ "${starship_exists}" -eq 1 && "${TERM}" != "linux" ]]; then
    eval "$(starship init bash)"
fi
function set_window_title() {
    # shellcheck disable=SC2116
    echo -ne "\033]0; $(echo "Terminal ${PWD/#$HOME/'~'}") \007"
}
# shellcheck disable=SC2034
starship_precmd_user_func="set_window_title"

# optional justfile completion.
if has_exe just; then
    alias jst='just'
    eval "$(just --completions bash)"
fi

# optional terraform completion.
if has_exe terraform; then
    alias tf="terraform"
    path="$(which terraform)"
    complete -C "${path}" terraform
    complete -C "${path}" tf
fi

# optional eza aliases.
if has_exe eza; then
    # eza
    alias z='eza'
    # eza list view
    alias zl='eza --long --header --binary --git --sort=name --group-directories-first -g -M -o --no-permissions -aa'
    # eza tree view
    alias zt='eza --long --header --binary --git --sort=name --group-directories-first -g -M -o --no-permissions --tree --level 2'
fi

export PAGER="less"
export LESS="-F -X -g -S -w -z-2 -#.1 -M -R"

# load own copy of .git-completion.bash if it exists
# shellcheck source=/dev/null
[[ -f "${HOME}/.git-completion.bash" ]] && . "${HOME}/.git-completion.bash"
