#!/bin/sh

workspaces() {
	# Define arrays
	ws=$(hyprctl workspaces -j | jq -r 'max_by(.id) | .id')
	o=()
	f=()
	t=()

	# Populate arrays
	for (( i=1; i<$((ws+1)); i++ )); do
		# Check if occupied
		o+=($(hyprctl workspaces -j | jq -r '.[] | select(.windows > 0).id' | grep "$i" || echo 0))
		# Check if focused
		f+=($(hyprctl monitors -j | jq -r '.[] | select(.focused) | .activeWorkspace.id' | grep "$i" || echo 0))
		# Check type
		t+=($(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $i) | .initialClass" | sort | uniq -c | sort -rn | head -n 1 | awk '{print $2}' || echo "empty"))
	done

	# Unoccupied
	un="0"

	echo ${o[*]}
	echo ${f[*]}
	echo ${t[*]}
	
	
	echo -n "(box :class \"works\" :orientation \"v\" :halign \"center\" :valign \"start\" :space-evenly \"false\" :spacing \"-5\""
	for (( i=0; i<$ws; i++ )); do
		echo -n " (button :onclick \"hyprctl dispatch workspace $((i+1))\" :class \"w$un${o[$i]}${f[$i]}\" \"$(symbol ${t[$i]})\")"
	done
	echo ")"
}

symbol() {
	case $1 in
        "kitty") echo "";;
        "firefox") echo "󰈹";;
        "code-oss") echo "󰨞";;
        "vlc") echo "󰕼";;
        "discord") echo "";;
        "jetbrains-idea-ce") echo "";;
        *"thunar"*) echo "󰝰";;
        *"FileRoller") echo "󰝰";;
        "Gimp-"*) echo "";;
        *"prismlauncher") echo "󰍳";;
        "steam") echo "";;
        *"planify") echo "";;
        *"xournalpp") echo "";;
        "Spotify") echo "";;
        "libreoffice-calc") echo "󱎏";;
        "libreoffice-writer") echo "󱎒";;
        "libreoffice-impress") echo "󱎐";;
        *) echo "󰣆";;  # Handle unknown inputs gracefully
    esac
}
workspaces
#socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
#	workspaces
#done
