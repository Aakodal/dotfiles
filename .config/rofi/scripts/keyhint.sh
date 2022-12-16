I3_CONFIG="$HOME/.config/i3/config"
mod_key="Win"
grep "^bindsym" ${I3_CONFIG} \
    | sed "s/-\(-\w\+\)\+//g;s/\$mod/${mod_key}/g;s/Mod1/Alt/g;s/exec //;s/bindsym //;s/^\s\+//;s/^\([^ ]\+\) \(.\+\)$/\2: \1/;s/^\s\+//" \
    | tr -s ' ' \
    | rofi -dmenu -theme ~/.config/rofi/rasi/keyhint.rasi