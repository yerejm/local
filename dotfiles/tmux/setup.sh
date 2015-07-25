#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

CURDIR="$(pwd)"

# install dotfile
ln -f -s "${CURDIR}/tmux.conf" "${HOME}/.tmux.conf"

TMUX_TPM_DIR=~/.tmux/plugins/tpm
if [ -e "${TMUX_TPM_DIR}" ]; then
  echo "Updating tmux tpm" && (cd "${TMUX_TPM_DIR}" && git pull)
else
  mkdir -p "$(dirname "${TMUX_TPM_DIR}")"
  git clone https://github.com/tmux-plugins/tpm "${TMUX_TPM_DIR}"
fi

