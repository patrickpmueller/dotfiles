#!/bin/bash

spaces (){
    ws=$(hyprctl workspaces -j | jq -r 'max_by(.id) | .id')
    WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')

    # Initialize an empty array to hold the final output
    output=()

    # Loop through each workspace ID
    for (( i=1; i<=$ws; i++ )); do
        # Check type
        initialClass=$((hyprctl clients -j | jq -r ".[] | select(.workspace.id == $i) | .initialClass" || echo "empty") | awk '{count[$0]++; if (count[$0] > max_count) { max_count = count[$0]; most_common = $0; }} END { print most_common; }') 
        
        sym=$(symbol $(echo $initialClass | xargs))

        # Construct the JSON object for the current workspace
        json=$(jq -n --arg id "$i" --arg sym "$sym" --argjson WORKSPACE_WINDOWS "$WORKSPACE_WINDOWS" '{id: $id | tonumber, symbol: $sym, windows: ($WORKSPACE_WINDOWS[$id] // 0)}')

        # Append the JSON object to the output array
        output+=("$json")
    done

    # Print the final JSON array
    echo $(echo "${output[@]}" | jq -s .)
}


symbol() {
	case $1 in
        "kitty") echo "";;
        "firefox") echo "󰈹";;
        "code-oss") echo "󰨞";;
        "vlc") echo "󰕼";;
        "discord") echo "";;
        "jetbrains-idea-ce") echo "";;
        "Thunar") echo "󰝰";;
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
        *"Inkscape") echo "";;
        "PrusaSlicer") echo "";;
        "FreeCAD") echo "";;
        "UltiMaker-Cura") echo "󰐫";;
        *) echo "󰣆";;  # Handle unknown inputs gracefully
    esac
}

spaces
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	spaces
done
