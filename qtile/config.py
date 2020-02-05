# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
import subprocess

import os

try:
    from typing import List  # noqa: F401
except ImportError:
    pass

mod = "mod4"

keys = [
    Key([mod], "h", lazy.layout.shrink_main()),
    Key([mod], "l", lazy.layout.grow_main()),

    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn("konsole")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),

    # resize window
    Key([mod, "control"], "l", lazy.layout.increase_ratio()),
    Key([mod, "control"], "h", lazy.layout.decrease_ratio()),

    # bindings for everyday stuffs
    Key([mod],"b",lazy.spawn("firefox")),

    # Change the volume if your keyboard has special volume keys.
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB+")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB-")
    ),
    # toggle is not working
    Key(
        [], "XF86AudioMute",
        lazy.spawn("amixer -c 0 -q set Master toggle")
    ),
]

def init_group_names():
    return [("TER", {'layout': 'monadtall'}),
            ("VIM", {'layout': 'monadtall'}),
            ("WWW", {'layout': 'monadtall'}),
            ("DOC", {'layout': 'monadtall'}),
            ("MUC", {'layout': 'monadtall'}),
            ("STM", {'layout': 'monadtall'}),
            ("MSG", {'layout': 'monadtall'}),
            ("VID", {'layout': 'monadtall'}),
            ("GFX", {'layout': 'floating'})]

def init_groups():
    return [Group(name, **kwargs) for name, kwargs in group_names]

if __name__ in ["config", "__main__"]:

    group_names = init_group_names()
    groups = init_groups()

##### SETS GROUPS KEYBINDINGS #####

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))          # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))   # Send current window to another group


border_defaults = dict(
        border_normal=('#7f8fa6'),
        border_focus=("#0097e6"),
        border_width=2,
        margin=6,
        )

layouts = [
    layout.Max(),
    layout.Stack( **border_defaults, num_stacks=2),
    layout.MonadTall(
        **border_defaults,
        ratio=0.60,
    ),
    layout.Floating(**border_defaults),
]

widget_defaults = dict(
    font='Ubuntu',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

color = ['#7f8fa6','#c23616','#dcdde1','#2f3640']
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.sep.Sep(foreground=color[3], padding=6,),
                widget.CurrentLayout(
                    foreground=color[0],
                    bakground=color[1],
                    ),
                widget.CurrentLayoutIcon(scale=0.65, forground=color[0], bakground=color[1]),
                widget.sep.Sep(foreground=color[0], padding=6),
                widget.GroupBox(
                    font='Ubuntu Bold',
                    margin_x=0,
                    margin_y=1,
                    padding_x=5,
                    padding_y=5,
                    fontsize=9,
                    borderwidth=3,
                    active=color[2],
                    inactive=color[0],
                    highlight_method='line',
                    highlight_color=['#273c75', '#273c75'],
                    spacing=0,
                    this_current_screen_border='#192a56',
                    this_screen_border='#718093',
                    padding=5,
                    ),
                
                widget.sep.Sep(foreground=color[3]), #add separator bars where deemed necessarhy
                widget.Prompt(),
                widget.WindowName(foreground=color[0]),
                widget.TextBox(text='', fontsize=20, foreground=color[0]),
                widget.Net(interface='wlp4s0', foreground=color[0]),
                widget.sep.Sep(foreground=color[3], padding=6,),
                widget.TextBox(text='', fontsize=30, foreground=color[0],),
                widget.Battery(foreground=color[0], update_interval=10,  format='{char} {percent:1.0%}',),
               # widget.BatteryIcon(battery='BAT0'),
                widget.sep.Sep(foreground=color[3], padding=6),
                widget.Systray(),
                widget.TextBox(text='', fontsize=20, foreground=color[0]),
                widget.Volume(fontsize=13, update_interval=0.0, foreground=color[0]),
                widget.TextBox(text='', fontsize=13, foreground=color[0]),
                widget.Clock(format='%H:%M %d/%m/%Y',fontsize=13,foreground=color[0]),
            ],
            24,background='#2f3640'
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# Launch when startup
@hook.subscribe.startup_once

def start_once():

    home = os.path.expanduser('~')

    subprocess.call([home + '/.config/qtile/autostart.sh'])

@hook.subscribe.client_new

def floating(window):

    floating_types = ['notification', 'toolbar', 'splash', 'dialog']

    transient = window.window.get_wm_transient_for()

    if window.window.get_wm_type() in floating_types or transient:

        window.floating = True





# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
