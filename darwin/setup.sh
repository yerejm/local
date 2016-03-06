#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# ask for sudo only once
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

CURDIR=$(dirname "${0}")
brewdir="${CURDIR}/brew-install"
BREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/master/install"

if [ ! -d "/usr/include" ]; then
  bash "${CURDIR}/xcode-cli-tools.sh"
fi

if [ ! -e "/usr/local/bin/brew" ]; then
  mkdir -p "${brewdir}" && (\
    cd "${brewdir}" && \
    curl -J -L -O "${BREW_INSTALLER}" && \
    (echo "\n" | ruby install) \
    )
fi
brew tap Homebrew/bundle
brew bundle --file="${CURDIR}/Brewfile"
bash "${CURDIR}/postinstall.sh"
bash "${CURDIR}/defaults.sh"

