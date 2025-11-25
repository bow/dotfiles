#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Get network interface names that might be shown
wireless_if="$(ip -o link show | grep ' state UP ' | awk -F: '/wl|wlan/ {print $2}' | tr -d ' ')"
eth_if="$(ip -o link show | grep ' state UP ' | awk -F: '/^( *[0-9]+: (en|eth))/ {print $2}' | tr -d ' ' | head -n1)"

# Launch polybar in all connected monitors
for mon in $(xrandr | grep " connected " | awk '{ print $1 }' | sort -r); do
    POLYBAR_MONITOR="${mon}" POLYBAR_WIRELESS_IF="${wireless_if}" POLYBAR_ETH_IF="${eth_if}" polybar top &
done
