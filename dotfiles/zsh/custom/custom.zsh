#####################################################
# ZSH
#####################################################

# Enable better mv, e.g. zmv '(*).md' '$1.markdown' for mass extension change
autoload -U zmv

# Automatically escape shell characters when pasting, e.g. URLs with &
unset zle_bracketed_paste # because it breaks url pasting
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

#####################################################
# EXPORTS
#####################################################
export LANG=en_US.UTF-8
export EDITOR='vim'
export INPUTRC=${HOME}/.inputrc

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

export MAKEFLAGS="-j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)"

if [ "$(uname)" = "Linux" ]; then
    PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
    export MANPATH=/home/linuxbrew/.linuxbrew/share/man:$MANPATH
    if [ -d ~/.mojosetup ]; then
        PATH=~/.mojosetup/bin:$PATH
        CMAKE_PREFIX_PATH="~/.mojosetup/cmake:$CMAKE_PREFIX_PATH"
    fi
    export PATH CMAKE_PREFIX_PATH
else
    export MANPATH=/usr/local/share/man:$MANPATH
fi

# Make Homebrew’s completions available in zsh
if type brew &>/dev/null; then
  export FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob '"'"'!.git/'"'"

#####################################################
# BINDS
#####################################################

bindkey 'OA' history-beginning-search-backward
bindkey 'OB' history-beginning-search-forward

#####################################################
# ALIASES
#####################################################

alias zshrc="vim ~/.oh-my-zsh/custom/custom.zsh"

if which caffeinate >/dev/null 2>&1; then
  alias vag="caffeinate vagrant"
  alias wget="caffeinate wget"
fi

local LS=ls
if which gls >/dev/null 2>&1; then
  LS=gls
fi
alias ls="${LS} -hbF --color=auto"
alias la="${LS} -ltahbF --color=auto"
alias lr="${LS} -ltrahbF --color=auto"

if [ "$(uname)" = "Darwin" ]; then
  alias locate="mdfind -name"
fi

alias x=exit
alias vi="vim"
alias webserve="python -m http.server"
alias mirror="wget -r -k -np --random-wait --tries=0 --retry-connrefused -N"
alias dl="wget -c -t 0"

if which otool >/dev/null 2>&1; then
    alias ldd="otool -L"
fi

alias gpf="git push --force-with-lease"

if which vagrant >/dev/null 2>&1; then
    alias vup="vag up"
    alias vht="vag halt"
    alias vdy="vag destroy"
    alias vsd="vag suspend"
    alias vre="vag resume"
    alias vpn="vag provision"
    alias vrd="vag reload"
    alias vss="vag status"
    alias vsh="vag ssh"
fi

alias mmv="noglob zmv -W"

#####################################################
# FUNCTIONS
#####################################################

function col {
  awk "{print \$$1}"
}

function skip {
  n=$(($1 + 1))
  cut -d' ' -f$n-
}

# process listening on port
function procport {
  service="4TCP"
  [[ -n "$1" ]] && service="${service}:$1"
  sudo lsof -n "-i${service}" | grep LISTEN
}

# file handles held by an open process
function procfile {
  lsof -p "$1" | col 9 | sort | uniq | while read -r file; do
    if test -f "${file}"; then
      echo "${file}"
    fi
  done
}

function cask {
    local CMD=$1
    shift
    brew $CMD --cask $@
}

#####################################################
# Shell customisation
#####################################################

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"

local LOCAL_ENV="$HOME/.oh-my-zsh/custom/local.zsh"
[ -f "$LOCAL_ENV" ] && source "$LOCAL_ENV"

