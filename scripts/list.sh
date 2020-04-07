#!/bin/bash

rc=/home/robovoid/.config/ranger/rc.conf
qtile=/home/robovoid/.config/qtile/config.py
nvim=/home/robovoid/.config/nvim/init.vim
picom=/home/robovoid/.config/picom.conf
zshrc=/home/robovoid/.zshrc
alacritty=/home/robovoid/.config/alacritty/alacritty.yml
addconf=/home/robovoid/scripts/list.sh
synconf=/home/robovoid/scripts/sync_config.sh

choice="ranger\nqtile\nnvim\npicom\nzsh\nalacritty\nAdd\nSync"

chosen=$(echo -e "$choice" | dmenu  -i -h 24 -fn 'JetBrains Mono Nerd Font:size=10' -nb '#1d2021' -nf '#b8bb26' -sb '#689d6a' -sf '#1d2021' -p "choose a config: ")

case "$chosen" in
    ranger) nvim "$rc";;
    qtile) nvim "$qtile";;
    nvim) nvim "$nvim";;
    picom) nvim "$picom";;
    zsh) nvim "$zshrc";;
    alacritty) nvim "$alacritty";;
    Add) nvim "$addconf";;
    Sync) exec "$Sync";;
esac
