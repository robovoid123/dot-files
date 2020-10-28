#!/usr/bin/python

import sys
import os

query = 'xrandr -q | grep -w connected > output.txt'
os.system(query)
with open('output.txt') as f:
    output = f.read()
query = "glxinfo | grep 'OpenGL vendor' | cut -d ' ' -f 4 > output.txt"
os.system(query)

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

if len(monitor) > 1:
    if card == 'NVIDIA':
        os.system('~/.screenlayout/one-main-nvidia.sh')
    elif card == 'Intel':
        os.system('~/.screenlayout/one-main.sh')
