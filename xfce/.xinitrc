xsetroot -cursor_name left_ptr

xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Escape"
xmodmap -e "add Caps_Lock = Escape"

xset +ft /usr/share/fonts/local
xset fp rehash

exec startxfce4 --with-ck-launch
