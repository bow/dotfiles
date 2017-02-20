#!/usr/bin/env bash

# Script for quick setup of stow-ed files

set -o errexit
set -o nounset
set -o pipefail

type stow >/dev/null 2>&1 || { "GNU Stow not found. Exiting."; exit 1; }

for prog in `find * -maxdepth 0 -type d | grep -vP 'virtualenvwrapper|xfce|pyenv'`;
do
    echo "Setting up ${prog} ..."
    stow -t ~ ${prog} || echo "Error when trying to set up ${prog}."
done
