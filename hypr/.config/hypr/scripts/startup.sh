#!/usr/bin/env sh

# start the swww daemon and set the wallpaper
(swww-daemon --format argb && swww img ${XDG_CONFIG_HOME}/hypr/backgrounds/soft-rose.jpg) &

# EasyEffects
exec easyeffects --gapplication-service > /dev/null 2>&1 &
