#!/usr/bin/env sh

# start the swww daemon and set the wallpaper
(swww-daemon --format xrgb && swww img ~/.local/share/backgrounds/heaven_or_lasvegas.png) &

# Network Manager applet
# nm-applet --indicator &

# eww
eww daemon &

