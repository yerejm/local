#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

CURDIR=$(dirname "${0}")
# brew ol' buddy, don't let me down...
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file="${CURDIR}/Brewfile"
