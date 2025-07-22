#!/usr/bin/env sh

# start the swww daemon and set the wallpaper
(swww-daemon --format xrgb && swww img ${XDG_CONFIG_HOME}/hypr/backgrounds/something-beautiful-in-nature.jpg) &

# EasyEffects
exec easyeffects --gapplication-service > /dev/null 2>&1 &

# Network Manager applet
nm-applet --indicator &
