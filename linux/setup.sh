#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

sudo dnf install -y \
	ulauncher \
	plank \
	fd-find \
	fzf \
	zsh \
	unzip \
	tmux \
	vim \
	ctags \
	git \
	mercurial \
	cmake \
	ShellCheck \
	valgrind \
	ansible \
	vagrant \
	patch \
	gcc \
	g++ \
	make \
	ninja-build

# brew ol' buddy, don't let me down...
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install \
    ripgrep-all
