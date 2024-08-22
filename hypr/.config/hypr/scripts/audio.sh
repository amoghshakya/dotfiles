#!/usr/bin/env bash

STEP=5%

# Check the argument passed to the script
case "$1" in
    raise)
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ $STEP+
        ;;
    lower)
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ $STEP-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    *)
        echo "Usage: $0 {raise|lower|mute}"
        exit 1
        ;;
esac

# eww update audio_info=$(bash ~/.config/eww/scripts/get-audio-info output)
