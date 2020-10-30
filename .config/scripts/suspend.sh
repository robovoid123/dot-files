#!/bin/bash

if [ $(echo -e 'Yes\nNo' | ~/scripts/dmenu.sh "Do you want to suspend: ") == 'Yes' ]
then
    systemctl suspend
fi

