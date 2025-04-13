#! /usr/bin/env bash

# Path to your AGS main script
AGS_SCRIPT_PATH="/home/am/dotfiles/ags/.config/ags/src/**/*"  # Adjust the path as needed

# Command to start AGS 
AGS_COMMAND="ags run . --gtk4"

# Watch for file changes using entr
find $AGS_SCRIPT_PATH | entr -r $AGS_COMMAND
