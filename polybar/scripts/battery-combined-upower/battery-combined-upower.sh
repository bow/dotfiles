#!/usr/bin/env bash

# Returns 1 if AC power is connected, 0 otherwise.
get_ac_status() {
    ac_id=$(upower -e | grep line_power_AC)
    if upower -i "${ac_id}" | grep -Eq 'online:\s+yes'; then
        echo 1
    else
        echo 0
    fi
}

# Returns the charge percentage from all batteries combined.
calc_battery_percent() {
    total_energy=0
    total_full=0

    for bat in $(upower -e | grep battery_BAT); do
        cur=$(upower -i "$bat" | awk '/energy:/{print $2}')
        full=$(upower -i "$bat" | awk '/energy-full:/{print $2}')
        total_energy=$(echo "$total_energy + $cur" | bc)
        total_full=$(echo "$total_full + $full" | bc)
    done

    total_full_int="$(printf "%.0f" "$total_full")"

    if [ "$total_full_int" -gt 0 ]; then
        echo "$total_energy / $total_full" | bc -l | awk '{printf("%.0f\n", $1 * 100)}'
    fi
}

# Prints the power status for display in polybar.
print_power_status() {
      battery_percent=$(calc_battery_percent)

      # System does not have battery.
      if [ -z "$battery_percent" ]; then
          icon=""
          echo "%{F#504945}$icon"

      # System has battery and it is plugged in.
      elif [ "$(get_ac_status)" -eq 1 ]; then

          # Battery is (close to) full.
          if [ "$battery_percent" -ge 99 ] || [ -z "$battery_percent" ] ; then
              icon=""
              echo "%{F#504945}$icon"

          # Battery is charging.
          else
              icon=""
              echo "%{F#504945}$icon %{F#e8e8d3}$battery_percent%"
          fi

      # System has battery and it is not plugged in.
      elif [ "$battery_percent" -ge 0 ]; then
          if [ "$battery_percent" -ge 85 ]; then
              icon=" "
          elif [ "$battery_percent" -ge 60 ]; then
              icon=" "
          elif [ "$battery_percent" -ge 40 ]; then
              icon=" "
          elif [ "$battery_percent" -ge 15 ]; then
              icon=" "
          else
              icon=" "
          fi

          echo "%{F#504945}$icon %{F#e8e8d3}$battery_percent%"

      # Error state.
      else
          icon=""
          echo "%{F#bd2c40}$icon"
      fi
}

case "$1" in
--update)
    pid=$(pgrep -xf "/bin/sh /home/wiar/.config/polybar/polybar-scripts/polybar-scripts/battery-combined-udev/battery-combined-udev.sh")

    if [ "$pid" != "" ]; then
        kill -10 "$pid"
    fi
    ;;
*)
    trap exit INT
    trap "echo" USR1

    while true; do
        print_power_status

        sleep 30 &
        wait
    done
    ;;
esac
