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
