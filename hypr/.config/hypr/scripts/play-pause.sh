#!/usr/bin/env bash

active_players=$(playerctl --list-all)

if [ -z "$active_players" ]; then
  echo "No media players found."
  exit 1
fi

last_player=$(playerctl -l | tail -n 1)

playing_player=$(playerctl --list-all | while read -r player; do
  status=$(playerctl --player="$player" status 2>/dev/null)
  if [ "$status" = "Playing" ]; then
    echo "$player"
  fi
done | tail -n 1)

if [ -n "$playing_player" ]; then
  playerctl --player="$playing_player" play-pause
elif [ -n "$last_player" ]; then
  playerctl --player="$last_player" play-pause
else
  echo "No media players are currently playing."
fi
