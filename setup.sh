#!/usr/bin/env bash

# Script for quick setup of stow-ed files

set -o errexit
set -o nounset
set -o pipefail

declare -A progs
progs=(
    [bash]="${HOME}"
    [conda]="${HOME}"
    [cookiecutter]="${HOME}"
    [ctags]="${HOME}"
    [elixir]="${HOME}"
    [git]="${HOME}"
    [lightdm]="${HOME}"
    [mercurial]="${HOME}"
    [ncmpcpp]="${HOME}"
    [ocaml]="${HOME}"
    [postgresql]="${HOME}"
    [r]="${HOME}"
    [readline]="${HOME}"
    [sqlite]="${HOME}"
    [termite]="${HOME}/.config/termite"
    [vim]="${HOME}"
    [xorg]="${HOME}"
    [xterm]="${HOME}"
)

type stow >/dev/null 2>&1 || { "GNU Stow not found. Exiting."; exit 1; }

echo "Adding tools settings ..."
for pn in "${!progs[@]}"
do
    loc="${progs[$pn]}"
    mkdir -p "${loc}"
    printf "  - %s at %s: " "${pn}" "${loc}"
    (stow -t "${loc}" "${pn}" && echo "ok") || echo "error!"
done
