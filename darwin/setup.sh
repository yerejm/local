#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [ ! -e "/usr/bin/clang" ]; then
    bash xcode-cli-tools.sh
fi

if [ ! -e "/usr/local/bin/brew" ]; then
  echo "\n" | ruby brew-install/install
fi
brew tap Homebrew/bundle
brew bundle

bash defaults.sh

