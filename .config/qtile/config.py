import os
import re
import socket
import subprocess
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.widget import Spacer

mod = 'mod1'
term = 'konsole'
config = '/home/michaelrivnak/.config/qtile/config.py'

##### DEFINING SOME WINDOW FUNCTIONS #####

@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

##### KEYBINDINGS #####

keys = [
    Key(
        [mod], "Return",
        lazy.spawn(term)                      # Open terminal
        ),
    Key(
        [mod], "Tab",
        lazy.next_layout()                      # Toggle through layouts
        ),
    Key(
        [mod, "shift"], "c",
        lazy.window.kill()                      # Kill active window
        ),
    Key(
        [mod, "shift"], "r",
        lazy.restart()                          # Restart Qtile
        ),
    Key([mod], "w",
        lazy.to_screen(0)                       # Keyboard focus screen(0)
        ),
    Key([mod], "e",
        lazy.to_screen(1)                       # Keyboard focus screen(1)
        ),
    Key([mod], "r",
        lazy.to_screen(2)                       # Keyboard focus screen(2)
        ),
    Key([mod, "control"], "k",
        lazy.layout.section_up()                # Move up a section in treetab
        ),
    Key([mod, "control"], "j",
        lazy.layout.section_down()              # Move down a section in treetab
        ),
    ### Window controls
    Key(
        [mod], "Down",
        lazy.layout.down()                      # Switch between windows in current stack pane
        ),
    Key(
        [mod], "Up",
        lazy.layout.up()                        # Switch between windows in current stack pane
        ),
    Key(
        [mod, "shift"], "Down",
        lazy.layout.shuffle_down()              # Move windows down in current stack
        ),
    Key(
        [mod, "shift"], "Up",
        lazy.layout.shuffle_up()                # Move windows up in current stack
        ),
    Key(
        [mod, "shift"], "Right",
        lazy.layout.grow(),                     # Grow size of current window (XmonadTall)
        lazy.layout.increase_nmaster(),         # Increase number in master pane (Tile)
        ),
    Key(
        [mod, "shift"], "Left",
        lazy.layout.shrink(),                   # Shrink size of current window (XmonadTall)
        lazy.layout.decrease_nmaster(),         # Decrease number in master pane (Tile)
        ),
    Key(
        [mod, "control"], "Left",                 # Move window to workspace to the left
        window_to_prev_group
        ),
    Key(
        [mod, "control"], "Right",                # Move window to workspace to the right
        window_to_next_group
        ),
    Key(
        [mod], "n",
        lazy.layout.normalize()                 # Restore all windows to default size ratios 
        ),
    Key(
        [mod], "m",
        lazy.layout.maximize()                  # Toggle a window between minimum and maximum sizes
        ),
    Key(
        [mod, "shift"], "space",
        lazy.layout.rotate(),                   # Swap panes of split stack (Stack)
        lazy.layout.flip()                      # Switch which side main pane occupies (XmonadTall)
        ),
    ### Stack controls
    Key(
        [mod, "control"], "Return",
        lazy.spawncmd()                    # Switch window focus to other pane(s) of stack
        ),
        
    ### Dmenu Run Launcher
    Key(
        [mod], "space",
        lazy.spawn("rofi -show drun -display-drun \"run >>> \" -width 25 -font 'Hack 10' -padding 10 -icon-theme 'Breeze-Dark'")
        ),
    ### Dmenu scripts launched with ALT + CTRL + KEY
    Key(
        [mod, "control"], "e",
        lazy.spawn("~/.config/dmenu/dmenu-edit-configs.sh")
        ),
    Key(
        [mod, "control"], "s",
        lazy.spawn("rofi -show ssh -display-ssh \"ssh >>> \" -width 25 -font 'Hack 10' -padding 10 -icon-theme 'Breeze-Dark'")
        ),
]

##### BAR COLORS #####

colors_dict = {
    'background':   '#282a36',
    'highlight':    '#434758',
    'foreground':   '#F8F8F8',
    'comment':      '#6272a4',
    'cyan':         '#8be9fd',
    'green':        '#50fa7b',
    'orange':       '#ffb86c',
    'pink':         '#ff79c6',
    'purple':       '#bd93f9',
    'red':          '#ff5555',
    'yellow':       '#f1fa8c'
}

##### GROUPS #####
group_names = [
    ("I", {'layout': 'monadtall'}),
    ("II", {'layout': 'monadtall'}),
    ("III", {'layout': 'monadtall'}),
    ("IV", {'layout': 'monadtall'}),
    ("V", {'layout': 'monadtall'}),
    ("VI", {'layout': 'monadtall', 'persist': False}),
    ("VII", {'layout': 'monadtall', 'persist': False}),
    ("VIII", {'layout': 'monadtall', 'persist': False}),
    ("IX", {'layout': 'monadtall', 'persist': False}),
    ("X", {'layout': 'monadtall', 'persist': False})
]

groups = [Group(name, **kwargs) for name, kwargs in group_names]


##### LAYOUTS #####

layout_theme = {
    "border_width": 2,
    "margin": 12,
    "border_focus": colors_dict['cyan'],
    "border_normal": colors_dict['background']
}

layouts = [
    layout.MonadWide(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Stack(stacks=2, **layout_theme),
    # layout.Columns(**layout_theme),
    layout.RatioTile(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Tile(shift_windows=True, **layout_theme),
    # layout.Matrix(**layout_theme),
    layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    # layout.TreeTab(
    #    font = "Ubuntu",
    #    fontsize = 10,
    #    sections = ["FIRST", "SECOND"],
    #    section_fontsize = 11,
    #    bg_color = "141414",
    #    active_bg = "90C435",
    #    active_fg = "000000",
    #    inactive_bg = "384323",
    #    inactive_fg = "a0a0a0",
    #    padding_y = 5,
    #    section_top = 10,
    #    panel_width = 320,
    #    **layout_theme
    # ),
    # layout.Floating(**layout_theme)
]

##### WIDGETS #####

widget_defaults = dict(
    font='Hack Bold',
    fontsize=14,
    padding=2,
    background=colors_dict['background'],
    foreground=colors_dict['foreground'],
    inactive=colors_dict['comment']
)

extension_defaults = widget_defaults.copy()

##### SCREENS #####

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    active=colors_dict['cyan'],
                    font='SF Pro Display',
                    fontsize=15,
                    highlight_color=colors_dict['highlight'],
                    highlight_method='block',
                    rounded=False,
                    this_current_screen_border=colors_dict['highlight']
                ),
                #widget.TaskList(
                #    foreground = "2e3440",
                #    border = "5e81ac",
                #    fontsize = 11,
                #    unfocused_border = "b48ead",
                #    highlight_method = "block",
                #    max_title_width=100,
                #    title_width_method="uniform",
                #    icon_size = 13,
                #    rounded=False,
                #),
                widget.Spacer(bar.STRETCH),
                widget.Systray(
                ),
                widget.Sep(
                    foreground=colors_dict['comment'],
                    padding=8,
                    size_percent=60
                ),
                widget.TextBox(
                    text='',
                    foreground=colors_dict['cyan']
                ),
                widget.Pacman(
                    foreground=colors_dict['cyan']
                ),
                widget.Sep(
                    foreground=colors_dict['comment'],
                    padding=8,
                    size_percent=60
                ),
                widget.TextBox(
                    text='',
                    foreground=colors_dict['pink']
                ),
                widget.CurrentLayout(
                    foreground=colors_dict['pink']
                ),
                widget.Sep(
                    foreground=colors_dict['comment'],
                    padding=8,
                    size_percent=60
                ),
                widget.TextBox(
                    text='',
                    foreground=colors_dict['green']
                ),
                widget.Memory(
                    format='{MemUsed}M/{MemTotal}M',
                    foreground=colors_dict['green']
                ),
                widget.Sep(
                    foreground=colors_dict['comment'],
                    padding=8,
                    size_percent=60
                ),
                widget.TextBox(
                    text='',
                    foreground=colors_dict['purple']
                ),
                widget.CPU(
                    format='CPU {freq_current}GHz {load_percent}%',
                    foreground=colors_dict['purple']
                ),
                widget.Sep(
                    foreground=colors_dict['comment'],
                    padding=8,
                    size_percent=60
                ),
                widget.TextBox(
                    text='',
                    foreground=colors_dict['cyan']
                ),
                widget.Clock(
                    format='%a %I:%M %p ',
                    foreground=colors_dict['cyan']
                )
            ],
            24,
            background="2e3440"
        ),
    ),
]

##### MOUSE #####

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

##### DEFINING A FEW THINGS #####

if __name__ in ["config", "__main__"]:

    # idk what any of this does
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

##### SETS GROUPS KEYBINDINGS #####

for i, (name, kwargs) in enumerate(group_names, 1):
    i = 0 if i == 10 else i
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))          # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))   # Send current window to another group

##### STARTUP APPLICATIONS #####

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

##### NEEDED FOR SOME JAVA APPS #####

#wmname = "LG3D"
wmname = "qtile"
