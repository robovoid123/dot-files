#!/usr/bin/python


import sys
import subprocess
import os
import json
from os.path import expanduser


print_help = lambda : print(f"""
'-o' To sync from dot file
'-i' To sync into dot files from pc
'-a' /home/abcd/.config/qtile/ To add a config file
'-p' to push in git
'-h' For more information
          """)

config_path_list = []

def clean_data(filename='configs.json'):
    global config_path_list
    if not os.path.exists(filename):
        with open(filename, mode='w', encoding='utf-8') as f:
            json.dump([], f)
    with open(filename) as f:
        config_path_list = json.load(f)

    temp_list = []

    for path in config_path_list:
        temp = path.split('/')
        flag = False
        if 'home' in temp:
            temp = temp[3:]
            flag = True
        temp = list(filter(lambda x: x != '.config', temp))
        temp = list(filter(lambda x : x != '~', temp))
        temp = list(filter(lambda x : x != '', temp))
        home = ''
        if not flag:
            home = expanduser('~')
        p_path = '/'.join(filter(lambda x : x != '~', path.split('/')))
        if  os.path.isdir(f'{home}/{p_path}'):
            temp = temp[0] + '/'
        else:
            temp = temp[0]
        temp_list.append(temp)

    config_path_list = list(zip(config_path_list, temp_list))

def write_json(data, filename='configs.json'):
    with open(filename, 'w') as f:
        json.dump(data, f, indent=4)

def open_json(path, filename='configs.json'):
    if not os.path.exists(filename):
        with open(filename, mode='w', encoding='utf-8') as f:
            json.dump([], f)
    with open(filename) as json_f:
        data = json.load(json_f)
        data.append(path)
    write_json(data)


def add_config():
    try:
        path = sys.argv[2]
        if os.path.exists(path):
            open_json(path)
        else:
            print('unknown config path not found!')
    except:
        print_help()


def remove_config():
    pass

def sync(rsync_command):
    subprocess.call(rsync_command, shell=True)
    print('executing: ', rsync_command)

def sync_in():
    for path, _ in config_path_list:
        path = '/'.join(filter(lambda x: x != '', path.split('/')))
        rsync_command = f"rsync -ra /{path} ~/dot-files/"
        sync(rsync_command)

def sync_out():
    for path, name in config_path_list:
        path = '/'.join(filter(lambda x: x != '', path.split('/')))
        rsync_command = f"rsync -ra ~/dot-files/{name} /{path}"
        sync(rsync_command)

def git_push(folder='dot-files'):
    home = expanduser('~')
    pa = f'{home}/{folder}'
    if os.path.exists(pa):
        os.chdir(pa)
        os.system('git init')
        os.system('git add .')
        os.system('git commit -m "update"')
        os.system('git push -u origin master')


# list of available commands
commands = ['-i', '-o', '-h', '-a', '-r', '-p']

if __name__ == '__main__':
    if len(sys.argv) > 1:
        if sys.argv[1] in commands:
            command = sys.argv[1]
            home = expanduser('~')
            os.chdir(f'{home}/scripts')
            clean_data()

            if command == '-i':
                sync_in()

            elif command == '-o':
                sync_out()

            elif command == '-a':
                add_config()

            elif command == '-r':
                pass

            elif command == '-p':
                git_push()

            elif command == '-h':
                print_help()

            quit()

    print_help()



