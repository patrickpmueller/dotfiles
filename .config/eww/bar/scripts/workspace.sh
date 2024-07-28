#!/bin/sh

workspaces() {

	ws1=1
	ws2=2
	ws3=3
	ws4=4
	ws5=5
	ws6=6
	ws7=7
	ws8=8

	# Unoccupied
	un="0"
# check if Occupied
	o1=$(hyprctl workspaces -j | jq '.[] | select(.windows > 0).id' | grep "$ws1" )
	o2=$(hyprctl workspaces -j | jq '.[] | select(.windows > 0).id' | grep "$ws2" )
	o3=$(hyprctl workspaces -j | jq '.[] | select(.windows > 0).id' | grep "$ws3" )
	o4=$(hyprctl workspaces -j | jq '.[] | select(.windows > 0).id' | grep "$ws4" )
	o5=$(hyprctl workspaces -j | jq '.[] | select(.windows > 0).id' | grep "$ws5" )
	o6=$(hyprctl workspaces -j | jq '.[] | select(.windows > 0).id' | grep "$ws6" )
	o7=$(hyprctl workspaces -j | jq '.[] | select(.windows > 0).id' | grep "$ws7" )
	o8=$(hyprctl workspaces -j | jq '.[] | select(.windows > 0).id' | grep "$ws8" )
	
	# check if Focused
	f1=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id' | grep "$ws1" )
	f2=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id' | grep "$ws2" )
	f3=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id' | grep "$ws3" )
	f4=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id' | grep "$ws4" )
	f5=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id' | grep "$ws5" )
	f6=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id' | grep "$ws6" )
	f7=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id' | grep "$ws7" )
	f8=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id' | grep "$ws8" )

	
	# check if Urgent
	# u1=$(bspc query -D -d .urgent --names | grep 1)
	# u2=$(bspc query -D -d .urgent --names | grep 2)
	# u3=$(bspc query -D -d .urgent --names | grep 3)
	# u4=$(bspc query -D -d .urgent --names | grep 4)
	# u5=$(bspc query -D -d .urgent --names | grep 5)

	echo 	"(box	:class \"works\" :orientation \"v\"	:halign \"center\"	:valign \"start\"	 :space-evenly \"false\" :spacing \"-5\" (button :onclick \"bspc desktop -f $ws1\"	:class	\"w$un$o1$f1\"	\"\") (button :onclick \"bspc desktop -f $ws2\"	:class \"w$un$o2$f2\"	 \"󰈹\") (button :onclick \"bspc desktop -f $ws3\"	:class \"w$un$o3$f3\" \"󰣆\") (button :onclick \"bspc desktop -f $ws4\"	:class \"w$un$o4$f4\"	\"\") (button :onclick \"bspc desktop -f $ws5\"	:class \"w$un$o5$f5\" \"󰓇\" )  (button :onclick \"bspc desktop -f $ws6\"	:class \"w$un$o6$f6\" \"\") (button :onclick \"bspc desktop -f $ws7\"	:class \"w$un$o7$f7\" \"\") (button :onclick \"bspc desktop -f $ws8\"	:class \"w$un$o8$f8\" \"\"))"

}
workspaces
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	workspaces
done
