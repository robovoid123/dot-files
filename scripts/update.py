#!/usr/bin/python

import sys
import subprocess


print_help = lambda : print(f"""
'-o' To sync from dot file
'-i' To sync into dot files from pc
'-h' For more information
          """)

config_path_list = [
    '~/.config/qtile/',
    '~/.config/nvim/',
    '~/.config/alacritty/',
    '~/.config/ranger/',
    '~/.zshrc',
    '~/.config/picom.conf',
    '~/.config/dunst/',
    '~/scripts/',
    '~/.config/bspwm/',
    '~/.config/polybar/',
    '~/.config/sxhkd/',
    '~/.config/vifm/',
]

def clean_data():
    global config_path_list
    temp_list = []

    for path in config_path_list:
        temp = path.split('/')
        [temp.remove(t) for t in temp if t == '.config']
        [temp.remove(t) for t in temp if t == '~']
        if '' in temp:
            temp.remove('')
            temp = temp[0] + '/'
        else:
            temp = temp[0]
        temp_list.append(temp)

    config_path_list = list(zip(config_path_list, temp_list))

def sync():
    pass

# list of available commands
commands = ['-i', '-o', '-h']

if __name__ == '__main__':
    if len(sys.argv) > 1:
        if sys.argv[1] in commands:
            command = sys.argv[1]
            clean_data()
            if command == '-i':
                for path, name in config_path_list:
                    path = '/'.join(filter(lambda x: x != '', path.split('/')))
                    rsync_command = f"rsync -ra {path} ~/dot-files/"
                    res = subprocess.call(rsync_command, shell=True)
                    print('executing: ', rsync_command, 'res: ', res)


