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

# https://fix-macosx.com
if [ ! -d fix-macosx ]; then
  git clone --depth 1 https://github.com/fix-macosx/fix-macosx fix-macosx
  ( cd fix-macosx && python fix-macosx.py ) && rm -rf fix-macosx
fi

if ! grep cachier "$HOME/.vagrant.d/plugins.json" >/dev/null 2>&1; then
  vagrant plugin install vagrant-cachier
fi
if ! grep hostsupdater "$HOME/.vagrant.d/plugins.json" >/dev/null 2>&1; then
  vagrant plugin install vagrant-hostsupdater
fi

