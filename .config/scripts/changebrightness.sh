#!/bin/bash
# changeBrightness

# Arbitrary but unique message id
msgId="991050"

# Change the brightness using light
    light "$@"

brightness="$(light -v 0)"

# Query light for the current brightness
dunstify -a "changeBrightness" -u low -i bightness-inc -r "$msgId" "Brightness: ${brightness}%"

