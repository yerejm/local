#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

CURDIR=$(pwd)

# install vim fonts
[ -d "${HOME}/Library" ] && mkdir -p "${HOME}/Library/Fonts"
bash fonts/install.sh

# install dotfile
ln -f -s "${CURDIR}/vimrc" "${HOME}/.vimrc"

# create vim home and support directories
VIM_HOME="${HOME}/.vim"
VIM_TMP="${VIM_HOME}/tmp"
for d in undo backup swap; do
  mkdir -p "${VIM_TMP}/${d}"
done
ln -s "${CURDIR}/ftplugin" "${HOME}/.vim/ftplugin"

# install vim-plug and plugins
if [ ! -f "${VIM_HOME}/autoload/plug.vim" ]; then
  curl -fLo "${VIM_HOME}/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim -S "${CURDIR}/viminstall.vim"
fi

