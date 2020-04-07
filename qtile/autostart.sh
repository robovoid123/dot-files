#! /bin/bash
card = glxinfo|egrep "OpenGL vendor"| cut -d ' ' -f 4 

if [ '$card'='NVIDIA' ]
then
    source ~/.screenlayout/nvdia-one-monitor.sh &
    qtile-cmd -o cmd -f restart &
else
    source ~/.screenlayout/multimonitor.sh &
    qtile-cmd -o cmd -f restart &
fi

dunst &
feh --bg-scale ~/.config/wall.jpg &
picom &
nm-applet 2> /dev/null &
cbatticon 2> /dev/null &
flameshot &
