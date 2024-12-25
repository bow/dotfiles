#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar in all connected monitors
for disp in $(xrandr | grep " connected " | awk '{ print $1 }' | sort -r); do
    MONITOR="${disp}" polybar top &
done
