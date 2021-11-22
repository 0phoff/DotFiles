#!/usr/bin/perl

# obmenu-generator - configuration file
# This file will be updated automatically.
# Any additional comment and/or indentation will be lost.

=for comment

|| FILTERING
    | skip_filename_re    : Skip a .desktop file if its name matches the regex.
                            Name is from the last slash to the end. (filename.desktop)
                            Example: qr/^(?:gimp|xterm)\b/,    # skips 'gimp' and 'xterm'

    | skip_entry          : Skip a destkop file if the value from a given key matches the regex.
                            Example: [
                                {key => 'Name', re => qr/(?:about|terminal)/i},
                                {key => 'Exec', re => qr/^xterm/},
                            ],

    | substitutions       : Substitute, by using a regex, in the values of the desktop files.
                            Example: [
                                {key => 'Exec', re => qr/xterm/, value => 'sakura'},
                                {key => 'Exec', re => qr/\\\\/,  value => '\\', global => 1},    # for wine apps
                            ],


|| ICON SETTINGS
    | icon_dirs_first     : When looking for icons, look in this directories first,
                            before looking in the directories of the current icon theme.
                            Example: [
                                "$ENV{HOME}/My icons",
                            ],

    | icon_dirs_second    : Look in this directories after looked in the directories of the
                            current icon theme. (Before /usr/share/pixmaps)
                            Example: [
                                "/usr/share/icons/gnome",
                            ],

    | icon_dirs_last      : Look in this directories at the very last, after looked in
                            /usr/share/pixmaps, /usr/share/icons/hicolor and some other
                            directories.
                            Example: [
                                "/usr/share/icons/Tango",
                            ],

    | strict_icon_dirs    : A true value will make the script to look only inside the directories
                            specified by you in either one of the above three options.

    | gtk_rc_filename     : Absolute path to the GTK configuration file.
    | missing_image       : Use this icon for missing icons (default: gtk-missing-image)


|| KEYS
    | name_keys           : Valid keys for the item names.
                            Example: ['Name[fr]', 'GenericName[fr]', 'Name'],   # french menu


|| PATHS
    | desktop_files_paths   : Absolute paths which contain .desktop files.
                              Example: [
                                '/usr/share/applications',
                                "$ENV{HOME}/.local/share/applications",
                                glob("$ENV{HOME}/.local/share/applications/wine/Programs/*"),
                              ],


|| NOTES
    | Regular expressions:
        * use qr/RE/ instead of 'RE'
        * use qr/RE/i for case insensitive mode

=cut

our $CONFIG = {
  "editor"              => "kak",
  "Linux::DesktopFiles" => {
                             desktop_files_paths     => [
                                                          "/usr/share/applications",
                                                          "/usr/local/share/applications",
                                                          "/usr/share/applications/kde4",
                                                          "/home/top/.local/share/applications",
                                                        ],
                             keep_unknown_categories => 1,
                             skip_entry              => [
                                                          { key => "Name", re => qr/About Xfce/ },
                                                          { key => "Name", re => qr/LightDM*/ },
                                                          { key => "Name", re => qr/compton*/ },
                                                          { key => "Name", re => qr/Avahi Zeroconf*/ },
                                                          { key => "Name", re => qr/GParted/ },
                                                          { key => "Comment[fr]", re => "Panel l\xC3\xA9ger" },
                                                        ],
                             skip_filename_re        => undef,
                             substitutions           => [
                                                          {
                                                            key => "Name",
                                                            re => qr/GNU Image Manipulation Program/i,
                                                            value => "GIMP",
                                                          },
                                                          {
                                                            key => "Name",
                                                            re => qr/PulseAudio Volume Control/i,
                                                            value => "Pulse Audio",
                                                          },
                                                          {
                                                            key => "Name",
                                                            re => qr/Avahi SSH Server Browser/i,
                                                            value => "Avahi SSH",
                                                          },
                                                          {
                                                            key => "Name",
                                                            re => qr/Avahi VNC Server Browser/i,
                                                            value => "Avahi VNC",
                                                          },
                                                          {
                                                            key => "Name",
                                                            re => qr/Openbox Configuration Manager/i,
                                                            value => "Openbox Configs",
                                                          },
                                                          {
                                                            key => "Name",
                                                            re => qr/Customize Look and Feel/i,
                                                            value => "LX Appearance",
                                                          },
                                                          { key => "Name", re => qr/Monitor Settings/i, value => "LX RandR" },
                                                          {
                                                            key => "Name",
                                                            re => qr/Oomox: customize icons and GTK themes/i,
                                                            value => "Oomox",
                                                          },
                                                        ],
                             terminalization_format  => "%s -e '%s'",
                             terminalize             => 1,
                             unknown_category_key    => "other",
                           },
  "missing_icon"        => "gtk-missing-image",
  "name_keys"           => ["Name"],
  "terminal"            => "termite",
  "VERSION"             => 0.66,
}
