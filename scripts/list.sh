#!/bin/bash

rc=/home/robovoid/.config/ranger/rc.conf
qtile=/home/robovoid/.config/qtile/config.py
nvim=/home/robovoid/.config/nvim/init.vim
compton=/home/robovoid/.config/compton/compton.conf
zshrc=/home/robovoid/.zshrc
alacritty=/home/robovoid/.config/alacritty/alacritty.yml
addconf=/home/robovoid/list.sh

choice="ranger\nqtile\nnvim\ncompton\nzsh\nalacritty\nAdd"

chosen=$(echo -e "$choice" | dmenu  -i -h 22 -fn 'JetBrains Mono Nerd Font:size=10' -nb '#2f3640' -nf '#a29bfe' -sb '#30336b' -sf '#dcdde1' -p "choose a config: ")

case "$chosen" in
    ranger) nvim "$rc";;
    qtile) nvim "$qtile";;
    nvim) nvim "$nvim";;
    compton) nvim "$compton";;
    zsh) nvim "$zshrc";;
    alacritty) nvim "$alacritty";;
    Add) nvim "$addconf";;
esac
