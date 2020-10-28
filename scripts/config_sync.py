#!/usr/bin/python

import sys
import subprocess
import os
import json
from os.path import expanduser

class SyncConf:
    # Temp list to hold all the config paths
    config_path_list = []

    # path to the config json
    filename = ''
    backup_path = ''

    # all the availabe help for tags
    help_tags = [
        ('-o', 'To sync from dot file'),
        ('-i', 'To sync into dot files from pc'),
        ('-a', '/home/abcd/.config/qtile/ To add a config file'),
        ('-p', 'To push in git'),
        ('-h', 'For more information')
    ]

    def __init__(self, config_path, backup_path):
        self.filename = config_path
        self.backup_path = backup_path
        if not os.path.exists(self.backup_path):
            print('creating new backup location')
            os.mkdir(self.backup_path)

        if not os.path.exists(self.filename):
            print('creating new json config')
            self.new_json_config(self.filename)

        with open(self.filename) as f:
            self.config_path_list = json.load(f)

            self.config_path_list = list(zip(
                self.config_path_list,
                self.clean_data(self.config_path_list)
            ))

    """
        prints help
        verbous = True then print detail help
    """
    def print_help(self, verbous=False):

        for h in self.help_tags:
            print(' '.join(h))

        # detail help content
        if verbous:
            pass

    def new_json_config(self, filename):
        with open(filename, mode='w', encoding='utf-8') as f:
            json.dump([], f)

    def write_json(self, data, filename):
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=4)

    def get_clean_path(self, path=''):
        path = os.path.normpath(path)
        path = list(filter(lambda x : x != '',path.split(os.sep)))

        if '~' in path:
            path = path[1:]
        else:
            path = path[2:]

        return path

    def clean_data(self, config_path_list = config_path_list):
        backup_path = []

        for path in self.config_path_list:
            path = self.get_clean_path(path)
            home = expanduser('~')
            t_path = os.path.join(*path)
            if os.path.isdir(f'{home}/{t_path}'):
                path = list(filter(lambda x : x != '.config', path))
                path = os.path.join(*path) + os.sep
            elif os.path.isfile(f'{home}/{t_path}'):
                path = list(filter(lambda x : x != '.config', path))
                path = os.path.join(*path)

            backup_path.append(path)
        return backup_path

    def add_config(self, path):
        if os.path.exists(path):
            with open(self.filename) as f:
                data = json.load(f)
                if path not in data:
                    data.append(path)
            self.write_json(data, self.filename)
        else:
            print('path does not exists')

    def remove_config(self, path):
        with open(self.filename) as f:
            data = json.load(f)
            if path in data:
                data.remove(path)
                self.write_json(data, self.filename)
            else:
                print('path not in list')

    def sync(self, rsync_command):
        subprocess.call(rsync_command, shell=True)
        print('executing: ', rsync_command)

    def sync_in(self):
        for path, _ in self.config_path_list:
            path = '/'.join(filter(lambda x: x != '', path.split('/')))
            rsync_command = f"rsync -ra /{path} {self.backup_path}"
            self.sync(rsync_command)

    def sync_out(self):
        for path, name in self.config_path_list:
            path = '/'.join(filter(lambda x: x != '', path.split('/')))
            rsync_command = f"rsync -ra {self.backup_path}{name} /{path}"
            self.sync(rsync_command)

    def git_push(self):
        home = expanduser('~')
        pa = f'{home}/{self.backup_path}'
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
            script_location = f'{home}/scripts'
            sync = SyncConf(
                config_path='config_path_list.json',
                backup_path='/home/robovoid/dot-files/'
            )
            os.chdir(script_location)

            if command == '-i':
                sync.sync_in()

            elif command == '-o':
                sync.sync_out()

            elif command == '-a':
                if len(sys.argv > 2):
                    sync.add_config(path=sys.argv[2])

            elif command == '-r':
                if len(sys.argv > 2):
                    sync.remove_config(path=sys.argv[2])

            elif command == '-p':
                sync.git_push()

            elif command == '-h':
                sync.print_help()
    else:
        pass

