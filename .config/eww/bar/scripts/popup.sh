calendar(){
    LOCK_FILE="$HOME/.cache/eww-calendar.lock"
    EWW_BIN="eww"

run() {
    ${EWW_BIN} -c $HOME/.config/eww/bar open calendar
}

# Run eww daemon if not running
if [[ ! `pidof eww` ]]; then
    ${EWW_BIN} daemon
    sleep 1
fi

# Open widgets
if [[ ! -f "$LOCK_FILE" ]]; then
    touch "$LOCK_FILE"
    run
else
    ${EWW_BIN} -c $HOME/.config/eww/bar close calendar
    rm "$LOCK_FILE"
fi
}

if [ "$1" = "launcher" ]; then
	anyrun	
elif [ "$1" = "wifi" ]; then
	kitty -e nmtui
elif [ "$1" = "audio" ]; then
	qpwgraph
elif [ "$1" = "calendar" ]; then
	calendar
fi
