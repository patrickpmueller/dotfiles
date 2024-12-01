#!/bin/bash

LOCK_FILE='/home/patrickpmueller/.cache/focus.lock'

if [[ ! -f "$LOCK_FILE" ]]; then
	hyprctl keyword decoration:active_opacity 0.8
	hyprctl keyword decoration:inactive_opacity 0.8
	hyprctl keyword decoration:blur:enabled true
	hyprctl keyword animations:enabled true
	hyprctl keyword general:gaps_in 12
	hyprctl keyword general:gaps_out 16
	hyprctl keyword decoration:rounding 8
	touch "$LOCK_FILE"
else
	hyprctl keyword decoration:active_opacity 1
	hyprctl keyword decoration:inactive_opacity 1
	hyprctl keyword animations:enabled false
	hyprctl keyword general:gaps_in 0
	hyprctl keyword general:gaps_out 0
	hyprctl keyword decoration:rounding 0
	sleep 0.4s
	hyprctl keyword decoration:blur:enabled false
	rm "$LOCK_FILE"
fi
