#!/bin/bash
if [ ! -n "$ZSH" ]; then
  ZSH=~/.oh-my-zsh
fi

set -o errexit
set -o nounset
set -o pipefail

CURDIR=$(dirname "$(pwd)/${0}")

if [ -d "$ZSH" ]; then
  (cd "${ZSH}" && git pull)
else
  git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$ZSH"
fi

for f in ${CURDIR}/custom/*.zsh; do
  if [ -e "${f}" ]; then
      ( cd "${ZSH}/custom" && ln -f -s "${f}" )
  fi
done
for f in ${CURDIR}/custom/themes/*.zsh-theme; do
  if [ -e "${f}" ]; then
      ( cd "${ZSH}/custom/themes" && ln -f -s "${f}" )
  fi
done

ln -f -s "${CURDIR}/zshrc" "${HOME}/.zshrc"
ln -f -s "${CURDIR}/inputrc" "${HOME}/.inputrc"

