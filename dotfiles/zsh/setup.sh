#!/bin/bash
# Based on https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh

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

ln -f -s "${CURDIR}/zshrc" "${HOME}/.zshrc"

for f in ${CURDIR}/custom/*.zsh; do
  if [ -e "${CURDIR}/${f}" ]; then
    ln -f -s "${CURDIR}/${f}" "${ZSH}/${f}"
  fi
done

if ! grep '/usr/local/bin/zsh' /etc/shells > /dev/null; then
    sudo bash -c "echo '/usr/local/bin/zsh' >> /etc/shells"
    chsh -s "$(grep '/zsh$' /etc/shells | tail -1)"
fi

ln -f -s "${CURDIR}/inputrc" "${HOME}/.inputrc"
