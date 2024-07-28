#!/bin/bash

LOCK_FILE="$HOME/.cache/dashboard.lock"

if [[ ! -f "$LOCK_FILE" ]]; then
    touch "$LOCK_FILE"
   	eww -c $HOME/.config/eww/dashboard open dashboard 
else
    eww -c $HOME/.config/eww/dashboard close dashboard
    rm "$LOCK_FILE"
fi
