#!/usr/bin/python

import sys
import subprocess

choice = subprocess.check_output('echo -e "yes\nno" | rofi -dmenu -p "Monitor setup?"', shell=True)

if choice:
    query = 'xrandr -q | grep -w connected > output.txt'
    subprocess.call(query, shell=True)
    with open('output.txt') as f:
        output = f.read()
    query = "glxinfo | grep 'OpenGL vendor' | cut -d ' ' -f 4 > output.txt"
    subprocess.call(query, shell=True)

    with open('output.txt') as f:
        card = f.read()

    output = list(filter(lambda x : x != '', output.split('\n')))

    monitor = []
    primary= []

    for m_info in output:
        m_info = m_info.split(' ')
        if 'primary' in m_info:
            primary.append(m_info[3].split('+')[0])
        else:
            primary.append(None)

        monitor.append(m_info[0])


    card = card.split('\n')[0]


    if card == 'NVIDIA':
        subprocess.call('~/.screenlayout/one-main-nvidia.sh', shell=True)
    elif card == 'Intel':
       subprocess.call('~/.screenlayout/one-main.sh', shell=True)
