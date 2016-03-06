if which caffeinate > /dev/null; then
  alias vag="caffeinate vagrant"
  alias wget="caffeinate wget"
fi

LS=ls
if which gls > /dev/null; then
  LS=gls
fi
alias ls="${LS} -hbF --color=auto"
alias la="${LS} -ltahbF --color=auto"
alias lr="${LS} -ltrahbF --color=auto"
unset LS

if which mdfind > /dev/null; then
  alias locate="mdfind -name"
fi

alias x=exit

alias vi="vim"
alias mirror="wget -r -k -np --random-wait --tries=0 --retry-connrefused -N"

alias webserve="python -m SimpleHTTPServer 8000"
alias dl="wget -c -t 0"

alias vup="vag up"
alias vht="vag halt"
alias vdy="vag destroy"
alias vsd="vag suspend"
alias vre="vag resume"
alias vpn="vag provision"
alias vrd="vag reload"
alias vss="vag status"
alias vsh="vag ssh"

alias mmv="noglob zmv -W"

alias outdated="brew cask list | xargs -P 8 -I % sh -c \"brew cask info '%' | paste  -s -d',' -\" | grep 'Not installed' | awk -F, '{print \$1}'"
