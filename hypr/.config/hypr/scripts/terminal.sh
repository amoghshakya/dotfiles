#!/usr/bin/env bash

config="$(xdg-user-dir CONFIG)/kitty/kitty.conf"

case $1 in
--float)
    kitty --class 'kitty_floating' --config "$config"
    ;;
--full)
    kitty --class 'kitty_fullscreen' --config "$config" --start-as=fullscreen --override window_padding_width=30 window_padding_height=30 font_size=10
    ;;
*)
    kitty --config "$config" $2 $3
    ;;
esac
