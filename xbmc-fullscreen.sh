#!/bin/bash

NAME='XBMC Media Center'
SCREEN_LEFT_POSITION="0,0"
SCREEN_RIGHT_POSITION="1920,0"

# Position XBMC Window function
position_xbmc_window() 
{

	# Wait for XBMC Window
	while [ -z "`wmctrl -l | grep \"$NAME\"`" ]
	do
		sleep 1
	done

	# Make sure XBMC is a free floating window
	wmctrl -r "$NAME" -b remove,fullscreen
	wmctrl -r "$NAME" -b remove,maximized_vert
	wmctrl -r "$NAME" -b remove,maximized_horz

	# Position XBMC window on correct screen
	if [ "$1" = "left" ]
	then		
		wmctrl -r "$NAME" -e ''"$SCREEN_LEFT_POSITION"',-1,-1,-1'
	elif [ "$1" = "right" ]
	then
		wmctrl -r "$NAME" -e ''"$SCREEN_RIGHT_POSITION"',-1,-1,-1'
	fi

	# Make it fullscreen
	wmctrl -r "$NAME" -b add,fullscreen
}

# Main
case "$1" in

	# Left screen
	left)
		SCREEN="left"
	;;
	# Right screen
	right)
		SCREEN="right"
	;;

	*)
		echo ""
		echo "Usage: $0 {left|right}"
		exit 1
esac

position_xbmc_window "$SCREEN" & SDL_VIDEO_ALLOW_SCREENSAVER=0 exec xbmc
