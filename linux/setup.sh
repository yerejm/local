#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get -y install \
  zsh \
  unzip \
  unrar \
  tmux \
  vim \
  exuberant-ctags \
  silversearcher-ag \
  git \
  mercurial \
  cmake \
  shellcheck \
  valgrind \
  ansible \
  vagrant \
  virtualbox-qt \
  redshift-gtk

