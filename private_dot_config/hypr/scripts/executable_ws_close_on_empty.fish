#!/usr/bin/fish

set wsId $argv[1]
set socatCommand "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock,fork"

function handleSocket
    if string match -r -q ".*closewindow.*" $argv[1]; and sleep 0.25; and test -n "$(hyprctl workspaces | grep -Ez "workspace ID.*\($wsId\).*windows: 0")"
        hyprctl dispatch split:workspace 1
        return 0
    end
    return 1
end

socat -s - $socatCommand | while read line
    if handleSocket $line
        set pid $(ps -eo pid,args | grep $socatCommand | grep -v grep | awk '{print $1}')
        kill $pid
        break
    end
end
