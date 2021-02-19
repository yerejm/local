#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

CURDIR=$(dirname "$(pwd)/${0}")

ln -f -s "$(pwd)" "${HOME}/.config/tmux"

TMUX_TPM_DIR="${HOME}/.config/tmux/plugins/tpm"
if [ -e "${TMUX_TPM_DIR}" ]; then
  echo "Updating tmux tpm" && (cd "${TMUX_TPM_DIR}" && git pull)
else
  mkdir -p "$(dirname "${TMUX_TPM_DIR}")"
  git clone https://github.com/tmux-plugins/tpm "${TMUX_TPM_DIR}"
fi
