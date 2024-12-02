#!/bin/bash

LOCK_FILE='/home/patrickpmueller/.cache/focus.lock'

if [[ ! -f "$LOCK_FILE" ]]; then
	hyprctl keyword decoration:active_opacity 0.9 
	hyprctl keyword decoration:inactive_opacity 0.6
	hyprctl keyword general:gaps_in 10
	hyprctl keyword general:gaps_out 14
	touch "$LOCK_FILE"
else
	hyprctl keyword decoration:active_opacity 1
	hyprctl keyword decoration:inactive_opacity 1
	hyprctl keyword general:gaps_in 0
	hyprctl keyword general:gaps_out 2
	rm "$LOCK_FILE"
fi
