#!/bin/bash

if [ $(echo -e 'Yes\nNo' | dmenu -i -p "Do you want to shutdown: ") == 'Yes' ]
then
    systemctl poweroff
fi

