#!/usr/bin/env bash

AGS_SCRIPT_PATH="$HOME/.config/ags"
AGS_COMMAND="ags run"
AGS_QUIT_COMMAND="ags quit"

# Starts AGS in the background
run_ags() {
    echo "Starting AGS..."
    $AGS_COMMAND &
}

# Kill all AGS instances cleanly
kill_ags() {
    echo "Killing AGS..."
    echo "######################################################################"
    $AGS_QUIT_COMMAND
}

# Run AGS initially
kill_ags
run_ags

# Debounce timer (200ms)
DEBOUNCE_NS=200000000
LAST_EVENT=0

# Watch the config directory
inotifywait -mrq -e modify,create,delete,move "$AGS_SCRIPT_PATH" --format '%w%f' |
while read -r file; do
    now=$(date +%s%N)
    delta=$((now - LAST_EVENT))

    if [[ $delta -lt $DEBOUNCE_NS ]]; then
        continue
    fi

    echo "File changed: $file"
    LAST_EVENT=$now

    kill_ags
    run_ags
done
