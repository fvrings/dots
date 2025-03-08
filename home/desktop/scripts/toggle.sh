#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ]; then
	hyprctl --batch "\
        keyword animations:enabled 0;"
	# keyword decoration:drop_shadow 0;\
	# keyword decoration:blur:enabled 0"
	# keyword general:gaps_in 0;\
	# keyword general:gaps_out 0;\
	# keyword general:border_size 0;\
	# keyword decoration:rounding 0"
	notify-send -u low -t 1000 "🎃 focusing"
	exit
else
	hyprctl --batch "\
        keyword animations:enabled 1"
	# keyword decoration:drop_shadow 1;\
	# keyword decoration:blur:enabled 1"
	# keyword general:gaps_in 5;\
	# keyword general:gaps_out 15;\
	# keyword general:border_size 2;\
	# keyword decoration:rounding 2"
	notify-send -u low -t 1000 "🕹️ animating"
	exit
fi
hyprctl reload
