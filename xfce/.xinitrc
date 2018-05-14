xsetroot -cursor_name left_ptr

setxkbmap -option "caps:escape" -option "compose:ralt"

xset +ft /usr/share/fonts/local
xset fp rehash

exec startxfce4 --with-ck-launch
