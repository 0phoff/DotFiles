#!/usr/bin/perl

# Addy's menu schema

=for comment

item:      add an item inside the menu               {item => ["command", "label", "icon"]},
cat:       add a category inside the menu            {cat => ["name", "label", "icon"]},
sep:       horizontal line separator                 {sep => undef}, {sep => "label"},
pipe:      a pipe menu entry                         {pipe => ["command", "label", "icon"]},
file:      include the content of an XML file        {file => "/path/to/file.xml"},
raw:       any XML data supported by Openbox         {raw => q(...)},
beg:       begin of a category                       {beg => ["name", "icon"]},
end:       end of a category                         {end => undef},
obgenmenu: generic menu settings                     {obgenmenu => ["label", "icon"]},
exit:      default "Exit" action                     {exit => ["label", "icon"]},

=cut

## NOTE:
## Keys and values are case sensitive. Keep all keys lowercase.
## Icon can be a either a direct path to an icon or a valid icon name.
## Category names are case insensitive. (X-XFCE and x_xfce are equivalent).

require "$ENV{HOME}/.config/obmenu-generator/config.pl";

## Text editor
my $editor = $CONFIG->{editor};

our $SCHEMA = [

{sep => "MAIN MENU"},
#          COMMAND                 LABEL              ICON
{item => ['rofi -show drun -font "Roboto Regular 8"',
	                       'Run..',        'system-run']},
{item => ['thunar', 'File Manager', 'system-file-manager']},
{item => ['x-terminal-emulator', 'Terminal', 'utilities-terminal']},
{item => ['x-www-browser', 'Web Browser', 'web-browser']},

{sep       => undef},
#          NAME            LABEL                ICON
{cat => ['utility',     'Accessories', 'applications-utilities']},
{cat => ['development', 'Development', 'applications-development']},
{cat => ['education',   'Education',   'applications-science']},
{cat => ['game',        'Games',       'applications-games']},
{cat => ['graphics',    'Graphics',    'applications-graphics']},
{cat => ['audiovideo',  'Multimedia',  'applications-multimedia']},
{cat => ['network',     'Network',     'applications-internet']},
{cat => ['office',      'Office',      'applications-office']},
{cat => ['other',       'Other',       'applications-other']},
{cat => ['settings',    'Settings',    'applications-accessories']},
{cat => ['system',      'System',      'applications-system']},



#             LABEL          ICON
#{beg => ['My category',  'cat-icon']},
#          ... some items ...
#{end => undef},

#            COMMAND     LABEL        ICON
#{pipe => ['obbrowser', 'Disk', 'drive-harddisk']},

## Generic advanced settings
#{sep       => undef},
#{obgenmenu => ['Openbox Settings', 'applications-engineering']},
#{sep       => undef},



## Custom advanced settings
#{sep       => undef},
#{beg => ['Advanced Settings', 'applications-engineering']},
#{item => ['obmenu-generator -s -c',    'Static menu',             'accessories-text-editor']},
#{item => ['obmenu-generator -p',       'Dynamic menu',            'accessories-text-editor']},
#{sep  => undef},
#{end => undef},

# Openbox category
{sep       => undef},
{beg => ['Openbox', 'openbox']},
{item      => ['openbox --reconfigure', 'Reconfigure', 'openbox']},
{item      => ['openbox --restart', 'Restart', 'openbox']},
{end => undef},


{end => undef},
{sep => undef},

## The xscreensaver lock command
#{item => ['xscreensaver-command -lock', 'Lock', 'system-lock-screen']},
## This option uses the default Openbox's "Exit" action
#{exit => ['Exit', 'application-exit']},

## This uses the 'oblogout' menu
{item => ['oblogout', 'Exit', 'application-exit']},
]
