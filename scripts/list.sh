#!/bin/zsh

TERMINAL=/usr/bin/alacritty
rc=/home/robovoid/.config/ranger/rc.conf
qtile=/home/robovoid/.config/qtile/config.py
nvim=/home/robovoid/.config/nvim/init.vim
compton=/home/robovoid/.config/compton/compton.conf
zshrc=/home/robovoid/.zshrc
alacritty=/home/robovoid/.config/alacritty/alacritty.yml
addconf=/home/robovoid/list.sh

choice="ranger\nqtile\nnvim\ncompton\nzsh\nalacritty\nAdd"

chosen=$(echo -e "$choice" | ~/scripts/dmenu.sh "choose a config: ")

case "$chosen" in
    ranger) "$TERMINAL" -e nvim "$rc";;
    qtile) "$TERMINAL" -e nvim "$qtile";;
    nvim) "$TERMINAL" -e nvim "$nvim";;
    compton) "$TERMINAL" -e nvim "$compton";;
    zsh) nvim "$TERMINAL" -e "$zshrc";;
    alacritty) "$TERMINAL" -e nvim "$alacritty";;
    Add) "$TERMINAL" -e nvim "$addconf";;
esac
