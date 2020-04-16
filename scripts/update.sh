#!/bin/bash

copied=0

function sync_in {
    echo "Syncing to dot-files"
    rsync -ra /home/robovoid/.config/qtile /home/robovoid/dot-files/ &
    rsync -ra /home/robovoid/.config/nvim /home/robovoid/dot-files/ &
    rsync -ra /home/robovoid/.config/alacritty /home/robovoid/dot-files/ &
    rsync -ra /home/robovoid/.config/ranger /home/robovoid/dot-files/ &
    rsync -ra /home/robovoid/.zshrc /home/robovoid/dot-files/ &
    rsync -ra /home/robovoid/.config/picom.conf /home/robovoid/dot-files/ &
    rsync -ra /home/robovoid/.config/dunst /home/robovoid/dot-files/ &
    rsync -ra /home/robovoid/scripts /home/robovoid/dot-files/ &
    rsync -ra /home/robovoid/.config/bspwm /home/robovoid/dot-files/ &
    rsync -ra /home/robovoid/.config/polybar /home/robovoid/dot-files/ &
    rsync -ra /home/robovoid/.config/sxhkd /home/robovoid/dot-files/ &
    rsync -ra /home/robovoid/.config/vifm /home/robovoid/dot-files/ &
}

function sync_out {
    #function_body
    echo "Syncing to device"
    rsync -ra  /home/robovoid/dot-files/qtile/  /home/robovoid/.config/qtile &
    rsync -ra  /home/robovoid/dot-files/nvim/  /home/robovoid/.config/nvim &
    rsync -ra  /home/robovoid/dot-files/alacritty/  /home/robovoid/.config/alacritty &
    rsync -ra  /home/robovoid/dot-files/ranger/  /home/robovoid/.config/ranger &
    rsync -ra  /home/robovoid/dot-files/.zshrc  /home/robovoid/.zshrc &
    rsync -ra  /home/robovoid/dot-files/picom.conf  /home/robovoid/.config/picom.conf &
    rsync -ra  /home/robovoid/dot-files/dunst/  /home/robovoid/.config/dunst &
    rsync -ra  /home/robovoid/dot-files/scripts/  /home/robovoid/scripts &
    rsync -ra  /home/robovoid/dot-files/bspwm/  /home/robovoid/.config/bspwm &
    rsync -ra  /home/robovoid/dot-files/polybar/  /home/robovoid/.config/polybar &
    rsync -ra  /home/robovoid/dot-files/sxhkd/  /home/robovoid/.config/sxhkd &
    rsync -ra  /home/robovoid/dot-files/vifm/  /home/robovoid/.config/vifm &
}

case "$1" in
    -i )
        sync_in
        ;;
    -o )
        sync_out
        ;;
    -h )
        echo " '-o' To sync from dot file "
        echo " '-i' To sync into dot files from pc"
        ;;
     *)
        echo "-h flag for help"
        ;;
esac
