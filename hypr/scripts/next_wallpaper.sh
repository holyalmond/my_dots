#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

INDEX_FILE="$HOME/.cache/hyprwall_index"

wallpapers=($(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | sort))

if [[ ! -f $INDEX_FILE ]]; then
    echo 0 > "$INDEX_FILE"
fi

index=$(cat "$INDEX_FILE")
index=$(( (index + 1) % ${#wallpapers[@]} ))
echo $index > "$INDEX_FILE"
next_wallpaper="${wallpapers[$index]}"
monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
hyprctl hyprpaper reload "$monitor,$next_wallpaper"
