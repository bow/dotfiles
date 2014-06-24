# .bashrc               
#
# (c) 2013 Wibowo Arindrarto  <bow@bow.web.id>


# check if bash is running interactively
[ -z "$PS1" ] && return

# load own copy of .git-prompt.sh if it exists
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

## HISTORY ##

# don't put duplicate lines in the history
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000


## DISPLAY ##

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
fi

# set .dircolors
if [ -e /bin/dircolors ]; then
    eval $(dircolors -b ~/.dircolors)
fi

# set prompt
#export PS1="\u@\h \[\033[01;34m\]\W\[\033[m\] \$ "
#export PS1='$(if [ "$USER" == "$(whoami)" ]; 
#            then echo "\u@\h $(get_vcs_stat)\[\033[01;34m\]\W\[\033[m\] \$ "; 
#            else echo "\u@\h $(get_vcs_stat)\[\033[01;31m\]\W\[\033[m\] \$ "; fi)'
export PS1='$(if [ "$USER" == "$(whoami)" ]; 
            then echo "\u@\h $(get_git_stat)\[\033[01;34m\]\W\[\033[m\] \$ "; 
            else echo "\u@\h $(get_git_stat)\[\033[01;31m\]\W\[\033[m\] \$ "; fi)'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export EDITOR="vim"


## ALIASES ##

alias ls='ls -F --color=auto'           # colorize
alias less='less -SN'                   # no wraps and include line numbers
alias grep='grep --color=auto'          # colorize
alias lname='ls -alF'                   # sort by name
alias lnames='ls -A'                    # sort by name, short
alias lsize='ls -lSrh'                  # sort by size
alias ltime='ls -ltrh'                  # sort by mtime
alias lext='ls -lXBh'                   # sort by extension
alias df='df -h'                        # human-readable output
alias du='du -sh'                       # ditto
alias mkdir='mkdir -p'                  # create parents by default
alias cp='cp -i'                        # interactive by default
alias mv='mv -i'                        # ditto
alias rm='rm -i'                        # ditto
alias reload='source ~/.bashrc'         # reload .bashrc    
alias grest='history | grep'
alias chmox='chmod +x'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ucsc='mysql --user=genome --host=genome-mysql.cse.ucsc.edu -A'
alias ensembl='mysql --user=anonymous --host=ensembldb.ensembl.org -A --port=3306'
alias R='/usr/bin/R --quiet'


## FUNCTIONS ##

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
    cat ~/.ssh/id_dsa.pub | ssh $1 'cat >> .ssh/authorized_keys'
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

# get active branch; for use in PS1
function git_br {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/$(git_br_dirty)\1|/"
}

# return asterisk if git branch has uncommitted changes
function git_br_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != 'nothing to commit, working directory clean' ]] && echo "*"
}

# get mercurial branch
function hg_br {
    hg branch 2> /dev/null | sed -e "s/\(.*\)/$(hg_br_dirty)\1|/"
}

# return asterisk if hg directory has changes
function hg_br_dirty {
    [[ $(hg status 2> /dev/null | wc -l) != 0 ]] && echo "*"
}

# get svn revision no.
function svn_rev() {
    svn info 2> /dev/null | awk '/^Revision:/{print $2}' | sed -e "s/\(.*\)/$(svn_st_dirty)\1|/"
}

# return asterisk if svn directory has changes
function svn_st_dirty {
    [[ $(svn status --ignore-externals 2> /dev/null | sed '/^X/d' | wc -l) != 0 ]] && echo "*"
}

# check which vcs system is present in the current / nearest parent
function get_vcs_stat {
  local dir="$PWD"
  local vcs
  local nick
  while [[ "$dir" != "/" ]]; do
    for vcs in git hg svn; do
      if [[ -d "$dir/.$vcs" ]] && hash "$vcs" &>/dev/null; then
        case "$vcs" in
          git)
              nick=$(git_br)
              color='\033[01;33m'
              ;;
          hg)
              nick=$(hg_br)
              color='\033[01;32m'
              ;;
          svn)
              nick=$(svn_rev)
              color='\033[01;31m'
              ;;
        esac
        [[ -n "$nick" ]] && printf "${1:-${color}%s\033[m}" "$nick"
        return 0
      fi
    done
    dir="$(dirname "$dir")"
  done
}

# controls git prompt and its color
# like get_vcs_stat, but works for git only and uses __git_ps1
function get_git_stat {
  export GIT_PS1_SHOWSTASHSTATE=true
  export GIT_PS1_SHOWDIRTYSTATE=true
  export GIT_PS1_SHOWUNTRACKEDFILES=true
  color='\033[01;33m'
  nick=$(__git_ps1 "(%s) ")
  [[ -n "$nick" ]] && printf "${1:-${color}%s\033[m}" "$nick"
  return 0
}

# nice log for SVN
function svnll() {
    svn log "$@"|( read; while true; do read h||break; read; m=""; while read l; do echo "$l" | grep -q '^[-]\+$'&&break; [ -z "$m" ] && m=$l; done; echo "$h % $m" | sed 's#\(.*\) | \(.*\) | \([-0-9 :]\{16\}\).* % \(.*\)#\1 \3 | \4 [\2]#'; done)
}

# load private settings if it exists
if [ -f ~/.bash_private ]; then
    source ~/.bash_private
fi
