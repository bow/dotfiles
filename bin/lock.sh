#!/bin/sh

FONT="Titillium"
COLOR_BG='#1d2021ee'
COLOR_FG='#ffffffff'
COLOR_BLANK='#00000000'
COLOR_RING="#007c5bff"
COLOR_RING_HL="#e3ac2dff"
COLOR_RING_BS="#d1472fff"
COLOR_RING_VER="${COLOR_RING_HL}"
COLOR_RING_WRONG="${COLOR_RING_BS}"

WALLPAPER="${HOME}/pics/wallpaper"
BG=$( (test -f "${WALLPAPER}-lock" && echo "${WALLPAPER}-lock") || echo "${WALLPAPER}" )

playerctl play-pause

i3lock \
    --nofork \
    -i "${BG}" \
    --fill \
    --ignore-empty-password \
    --show-failed-attempts \
    --verif-text "" \
    --wrong-text "" \
    --noinput-text "" \
    --lock-text "locking" \
    --lockfailed-text "locking failed" \
    --radius 100 \
    --ring-color "${COLOR_RING}" \
    --inside-color "${COLOR_BG}" \
    --keyhl-color "${COLOR_RING_HL}" \
    --bshl-color "${COLOR_RING_BS}" \
    --line-color "${COLOR_BLANK}" \
    --verif-color "${COLOR_FG}" \
    --ringver-color "${COLOR_RING_VER}" \
    --insidever-color "${COLOR_BG}" \
    --verif-font "${FONT}" \
    --wrong-color "${COLOR_FG}" \
    --ringwrong-color "${COLOR_RING_WRONG}" \
    --insidewrong-color "${COLOR_BG}" \
    --wrong-font "${FONT}" \
    --clock \
    --force-clock \
    --time-str "%H:%M" \
    --time-pos "ix:iy-240" \
    --time-color "${COLOR_FG}" \
    --time-size 140 \
    --time-font "${FONT}" \
    --date-str "%A, %d %B %Y" \
    --date-pos "tx:ty+50" \
    --date-color "${COLOR_FG}" \
    --date-size 30 \
    --date-font "${FONT}" \
    --greeter-text "$(getent passwd "${USER}" | cut -d ':' -f 5) · $(hostname -f)" \
    --greeter-pos "15:h-15" \
    --greeter-align 1 \
    --greeter-color "${COLOR_FG}" \
    --greeter-size 20 \
    --greeter-font "${FONT}" \
    && playerctl play-pause
