#!/usr/bin/env bash
wallpapers="/home/$USER/Pictures/wallpapers/"

pos_list=('center' 'top' 'left' 'right' 'bottom' 'top-left' 'top-right' 'bottom-left' 'bottom-right')
tp_list=("fade" "left" "right" "top" "bottom" "wipe" "wave" "grow" "center" "any" "outer")

img=$(fd -a "gif" "$wallpapers" | shuf -n 1 --random-source=/dev/random)
pos=$(printf "%s\n" "${pos_list[@]}" | shuf -n 1)
tp=$(printf "%s\n" "${tp_list[@]}" | shuf -n 1)
angle=$(od -An -N2 -i /dev/urandom | awk '{print $1%360}')
swww img "$img" --transition-duration 2 --transition-fps 30 -t "$tp" --transition-pos "$pos" --transition-angle "$angle"
