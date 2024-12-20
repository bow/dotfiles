#!/bin/sh

awk '{printf("%{F#665c54} %{F#e8e8d3}%2.1f · %2.1f", $1, $2)}' < /proc/loadavg
