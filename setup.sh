#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [ -z "${BASH_VERSION}" ]; then
  # not really needed due to pipefail dependency
  echo "This setup must be run using bash."
  exit 1
fi

BASE_DIR=$(dirname "$(pwd)/${0}")

case $OSTYPE in
  darwin*) platform="${OSTYPE//[0-9.]/}" ;;
  linux*) platform="${OSTYPE//\-gnu/}" ;;
  default)
    echo "Unsupported $OSTYPE"
    exit
    ;;
esac
platformdir="${BASE_DIR}/${platform}"
[[ -d "${platformdir}" ]] && (cd "${platformdir}" && bash setup.sh)

for moddir in ${BASE_DIR}/dotfiles/*; do
  [[ -d "${moddir}" ]] && (cd "${moddir}" && bash setup.sh)
done

echo "Restart required."
exit 0
