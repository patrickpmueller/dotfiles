#!/bin/bash

LOCK_FILE='/home/patrickpmueller/.cache/focus.lock'

if [[ ! -f "$LOCK_FILE" ]]; then
	hyprctl keyword decoration:active_opacity 0.88
	hyprctl keyword decoration:inactive_opacity 0.88
	touch "$LOCK_FILE"
else
	hyprctl keyword decoration:active_opacity 1
	hyprctl keyword decoration:inactive_opacity 1
	rm "$LOCK_FILE"
fi
