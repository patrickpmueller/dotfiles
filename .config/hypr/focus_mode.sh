#!/bin/bash

LOCK_FILE='/home/patrickpmueller/.cache/focus.lock'

if [[ ! -f "$LOCK_FILE" ]]; then
	hyprctl keyword decoration:active_opacity 0.8
	hyprctl keyword decoration:inactive_opacity 0.8
	hyprctl keyword decoration:blur:enabled true
	touch "$LOCK_FILE"
else
	hyprctl keyword decoration:active_opacity 1
	hyprctl keyword decoration:inactive_opacity 1
	hyprctl keyword decoration:blur:enabled false
	rm "$LOCK_FILE"
fi
