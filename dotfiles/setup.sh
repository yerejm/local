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

# ask for sudo only once
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

for moddir in ${CURDIR}/*; do
  if [ -d "${moddir}" ]; then
    echo "#################################################################"
    echo "# DOTFILE SET UP - $(basename "${moddir}")"
    echo "#################################################################"
    setup_file="${moddir}/setup.sh"
    if [ -f "${setup_file}" ]; then
      ( cd "${moddir}" && bash setup.sh )
      echo "Done."
    else
      echo "No setup detected. Skipping..."
    fi
  fi
done

exit 0
