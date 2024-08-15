#!/usr/bin/env bash

script_dir=$(dirname "$(realpath "$0")")
sh "$script_dir/accent.sh"

rofi \
    -show "$1" \
    -modi run,drun,window,filebrowser \
    -no-lazy-grab \
    -scroll-method 0 \
    -drun-match-fields all \
    -drun-display-format "{name}" \
    -no-drun-show-actions \
    -terminal "$(xdg-user-dir CONFIG)/hypr/scripts/terminal.sh" \
    -kb-cancel Escape \
    -theme "$(xdg-user-dir CONFIG)/rofi/launcher.rasi"
