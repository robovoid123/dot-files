#!/bin/bash

if [ $(echo -e 'Yes\nNo' | dmenu -i -h 22 -fn 'Jet Brains Mono Nerd Font:size=10' -nb '#2f3640' -nf '#a29bfe' -sb '#30336b' -sf '#dcdde1' -p "Do you want to shutdown: ") == 'Yes' ]
then
    systemctl poweroff
fi

