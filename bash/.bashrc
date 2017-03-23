# .bashrc
# Wibowo Arindrarto  <bow@bow.web.id>

# check if bash is running interactively
[ -z "$PS1" ] && return

# load own copy of .git-prompt.sh if it exists
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

# load own copy of .git-completion.bash if it exists
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
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
    eval $(dircolors -b ~/.dircolors)
fi

# set prompt
nocol='\033[0m'
green='\033[32m'
red='\033[31m'
yellow='\033[33m'
blue='\033[34m'
purple='\033[35m'
cyan='\033[36m'

function set_prompt {
    venv_name="" && [[ -n $PYENV_VIRTUAL_ENV ]] && venv_name="\[${purple}\](⚶ $(basename $PYENV_VIRTUAL_ENV)) \[${nocol}\]"
    PS1="\n${nocol}\`if [ \$? = 0 ]; then echo "${green}"; else echo "${red}"; fi\`↮\[${nocol}\] \[${blue}\]\u@\h\[${nocol}\] ${venv_name}\[${cyan}\]$(get_git_stat)\[${nocol}\]\[${yellow}\]\w\[${nocol}\]\n\$ "
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
alias ucsc='mysql --user=genome --host=genome-mysql.cse.ucsc.edu -A'
alias ensembl='mysql --user=anonymous --host=ensembldb.ensembl.org -A --port=3306'
alias xclip='xclip -selection c'        # copy to X clipboard

# create dir and cd into it
function mkcd() { mkdir -p "$1" && cd "$1"; }

# change owner to current user
function mkmine() { sudo chown -R ${USER} ${1:-.}; }

# check wikipedia summary
function wiki() { dig +short txt "$*".wp.dg.cx; }

# calculator
function calc() { echo "$*" | bc; }

# passwordless ssh login
function pwdless() {
    cat ~/.ssh/id_rsa.pub | ssh $1 'mkdir .ssh && cat >> .ssh/authorized_keys'
}

# mount iso images
function mountiso() {
    if [ ! "$1" ]; then
        echo "ERROR: missing iso image argument"
        return
    fi
    mountdir="/media/${1%.iso}"
    if [ ! -d $mountdir ]; then
        sudo mkdir -p $mountdir
    fi
    sudo mount -o loop "$1" "$mountdir"
}

# unmount iso images
function umountiso() {
    if [ -d $1 ]; then
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
        tar czvf ${target}.tar.gz $target ;;
    bz)
        tar cjvf ${target}.tar.bz2 $target ;;
    xz)
        tar cJvf ${target}.tar.xz $target ;;
    7z)
        7zr a ${target}.7z $target ;;
    rar)
        rar a ${target}.rar $target ;;
    zip)
        zip -r ${target}.zip $target ;;
    *)
        echo "Usage: pack [gzip|bzip2|xz|7z|rar|zip] [target]" ;;
    esac
}

# unpack directories
function unpack() {
    case $1 in
    *.tar.gz | *.tgz | *.tar.bz2 | *.tbz2 | *.tar.xz | *.txz)
        tar xfv $1 ;;
    *.7z)
        7zr x $1 ;;
    *.rar)
        unrar x $1 ;;
    *.zip)
        unzip $1 ;;
    *)
        echo "Usage: unpack [target]" ;;
    esac
}

# check weather from wego
function wttr() {
    curl http://wttr.in/${1:-Leiden}
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
    source ~/.bash_private
fi

# pyenv config
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
