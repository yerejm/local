export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export MANPATH=/usr/local/man:/usr/share/man:$MANPATH
export EDITOR=/usr/local/bin/vim
export MAKEFLAGS="-j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)"

