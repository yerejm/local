#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [ -z "${BASH_VERSION}" ]; then
  # not really needed due to pipefail dependency
  echo "This setup must be run using bash."
  exit 1
fi

CURDIR=$(dirname "$(pwd)/${0}")

case $OSTYPE in
  darwin*) platform="${OSTYPE//[0-9.]/}" ;;
  linux*) platform="${OSTYPE//\-gnu/}" ;;
  default)
    echo "Unsupported $OSTYPE"
    exit
    ;;
esac

# ask for sudo only once
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

setups="${platform} dotfiles"
for setup in ${setups}; do
  setup_dir="${CURDIR}/${setup}"
  if [ -d "${setup_dir}" ]; then
    echo "#################################################################"
    echo "# EXECUTING SET UP - ${setup}"
    echo "#################################################################"
    if [ -f "${setup_dir}/setup.sh" ]; then
      ( cd ${setup_dir} && bash setup.sh ) && echo "${setup} complete."
    else
      echo "WARNING: No setup detected. Skipping..."
    fi
  fi
done

if [ ! -d "${HOME}/.ssh" ]; then
  ssh-keygen -t rsa -b 4096
fi

echo "A restart will be required."
exit 0
