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
platformdir="${CURDIR}/${platform}"
if [ -d "${platformdir}" ]; then
  echo "#################################################################"
  echo "# PLATFORM SET UP - $(basename "${platformdir}")"
  echo "#################################################################"
  bash "${platformdir}/setup.sh"
fi

for moddir in ${CURDIR}/dotfiles/*; do
  if [ -d "${moddir}" ]; then
    echo "#################################################################"
    echo "# DOTFILE SET UP - $(basename "${moddir}")"
    echo "#################################################################"
    bash "${moddir}/setup.sh"
  fi
done

echo "A restart will be required."
exit 0
