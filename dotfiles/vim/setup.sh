#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

CURDIR=$(dirname "$(pwd)/${0}")
FONT="https://github.com/powerline/fonts/raw/master/Meslo/Meslo%20LG%20S%20Regular%20for%20Powerline.otf"
FONT_INSTALLER="https://raw.githubusercontent.com/powerline/fonts/master/install.sh"

# install dotfile
ln -f -s "${CURDIR}/vimrc" "${HOME}/.vimrc"

# create vim home and support directories
VIM_HOME="${HOME}/.vim"
VIM_TMP="${VIM_HOME}/tmp"
for d in undo backup swap; do
  mkdir -p "${VIM_TMP}/${d}"
done
if [ ! -e "${HOME}/.vim/ftplugin" ]; then
    ln -f -s "${CURDIR}/ftplugin" "${HOME}/.vim/ftplugin"
fi

# install vim-plug and plugins
if [ ! -f "${VIM_HOME}/autoload/plug.vim" ]; then
  curl -fLo "${VIM_HOME}/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim -S "${CURDIR}/viminstall.vim"
fi
