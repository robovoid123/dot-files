#!/bin/bash

if [ $(echo -e 'Yes\nNo' | ~/scripts/dmenu.sh "Do you want to shutdown: ") == 'Yes' ]
then
    systemctl poweroff
fi

