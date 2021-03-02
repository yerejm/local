#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

dist=$(grep ^ID= /etc/os-release | cut -c 4-)
case $dist in
    fedora) sudo dnf install -y \
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
        ;;
    debian) sudo apt install -y \
        plank \
        fd-find \
        fzf \
        zsh \
        unzip \
        tmux \
        vim \
        universal-ctags \
        git \
        mercurial \
        cmake \
        shellcheck \
        valgrind \
        ansible \
        vagrant \
        patch \
        gcc \
        g++ \
        make \
        ninja-build
        ;;
    *) >&2 echo "Unsupported distribution $dist"
        ;;
esac

# brew ol' buddy, don't let me down...
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/home/linuxbrew/.linuxbrew/bin/brew install \
    ripgrep-all
