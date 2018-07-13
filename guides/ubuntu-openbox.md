# Ubuntu Openbox install
Packages installed during ubuntu openbox setup

## Base
https://ubuntuforums.org/showthread.php?t=2361552
  1. Install ubuntu minimal without extra packages (except fonts)
  2. Remove $vt_handoff from grub
  3. Update grub config (remove quiet and splash)
  4. sudo apt install lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
  5. sudo apt install xorg xserver-xorg ubuntu-drivers-common intel-microcode mesa-utils mesa-utils-extra
  6. sudo apt install openbox obconf obmenu
  7. sudo apt install xfce4-power-manager xfce4-volumed numlockx
  8. sudo apt install wicd thunar xfce4-terminal synaptic xfce4-volumed

## Openbox Ricing
https://www.devpy.me/your-guide-to-a-comfortable-linux-desktop-with-openbox/
https://www.reddit.com/r/unixporn/comments/8apait/openbox_fool_in_the_rain/
  1. sudo apt install xsettingsd lxappearance nitrogen
  2. sudo apt install tint2 conky compton rofi dunst libnotify-bin
  3. Install Openbox Bonzo theme  *(obconf)*
  4. Install Lumiere GTK theme  *(lxappearance & lightdm_gtk_greeter_settings)*
  5. Install numix-icon-theme + numix-icon-theme-circle + numix-cursor-theme *(lxappearance)*
  7. Install obmenu-generator *(deb file)*
      - sudo apt install python-distutils-extra
  8. Install oblogout + adeos-archlabs_oblogout-theme *(from source)*
      - For oblogout, set hal=false in /etc/oblogout.conf
  9. Install and configure xscreensaver
  10. Install all nord themes
