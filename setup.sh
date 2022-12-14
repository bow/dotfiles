#!/usr/bin/env bash

# Script for quick setup of stow-ed files

set -o errexit
set -o nounset
set -o pipefail

declare -A progs
progs=(
    [alacritty]="${HOME}/.config/alacritty"
    [bash]="${HOME}"
    [conda]="${HOME}"
    [elixir]="${HOME}"
    [gitconfig]="${HOME}"
    [gitignore]="${HOME}/.config/git"
    [i3]="${HOME}/.config/i3"
    [ignore]="${HOME}"
    [lightdm]="${HOME}"
    [ncmpcpp]="${HOME}"
    [neovim]="${HOME}/.config/nvim"
    [ocaml]="${HOME}"
    [picom]="${HOME}/.config/picom"
    [postgresql]="${HOME}"
    [r]="${HOME}"
    [rofi]="${HOME}/.config/rofi"
    [readline]="${HOME}"
    [sqlite]="${HOME}"
    [starship]="${HOME}/.config"
    [xorg]="${HOME}"
    [xterm]="${HOME}"
    [zathura]="${HOME}/.config/zathura"
    [xdg]="${HOME}/.config"
)

type stow >/dev/null 2>&1 || { echo "GNU Stow not found. Exiting."; exit 1; }

echo "Adding tools settings ..."
for pn in "${!progs[@]}"
do
    loc="${progs[$pn]}"
    mkdir -p "${loc}"
    printf "  - %s at %s: " "${pn}" "${loc}"
    (stow -t "${loc}" "${pn}" && echo "ok") || echo "error!"
done
