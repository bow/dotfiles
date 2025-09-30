#!/usr/bin/env bash

# Script for quick setup of stow-ed files

set -o errexit
set -o nounset
set -o pipefail

declare -A progs
progs=(
    [alacritty]="${HOME}/.config/alacritty"
    [bash]="${HOME}"
    [bat]="${HOME}/.config/bat"
    [bin]="${HOME}/.local/bin"
    [clang-format]="${HOME}"
    [conda]="${HOME}"
    [dig]="${HOME}"
    [direnv]="${HOME}/.config/direnv"
    [elixir]="${HOME}"
    [environment.d]="${HOME}/.config/environment.d"
    [ghostty]="${HOME}/.config/ghostty"
    [gitconfig]="${HOME}"
    [gitignore]="${HOME}/.config/git"
    [i3]="${HOME}/.config/i3"
    [ignore]="${HOME}"
    [ncmpcpp]="${HOME}"
    [nvim]="${HOME}/.config/nvim"
    [ocaml]="${HOME}"
    [picom]="${HOME}/.config/picom"
    [polybar]="${HOME}/.config/polybar"
    [postgresql]="${HOME}"
    [r]="${HOME}"
    [rofi]="${HOME}/.config/rofi"
    [readline]="${HOME}"
    [redshift]="${HOME}/.config/redshift"
    [ripgrep]="${HOME}"
    [sqlite]="${HOME}"
    [starship]="${HOME}/.config"
    [systemd]="${HOME}/.config/systemd"
    [tmux]="${HOME}"
    [xorg]="${HOME}"
    [xterm]="${HOME}"
    [xdg]="${HOME}/.config"
    [yazi]="${HOME}/.config/yazi"
    [zathura]="${HOME}/.config/zathura"
)

type stow >/dev/null 2>&1 || {
    echo "GNU Stow not found. Exiting."
    exit 1
}

echo "Adding tools settings ..."
for pn in "${!progs[@]}"; do
    loc="${progs[$pn]}"
    mkdir -p "${loc}"
    printf "  - %s at %s: " "${pn}" "${loc}"
    (stow -t "${loc}" "${pn}" && echo "ok") || echo "error!"
done
