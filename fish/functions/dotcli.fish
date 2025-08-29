#!/usr/bin/env fish

function dotcli
    argparse h/help r/reload -- $argv
    or return

    switch $argv[1]
        case reload
            ags quit
            nohup ags run ~/dotshell/app.ts &
        case work
            open_work
    end
    return 0
end


function open_work
    v4l2-ctl --set-fmt-video=width=3840,height=2160
    nohup app2unit mpv av://v4l2:/dev/video0 --profile=low-latency --untimed --osc=no > /dev/null 2>&1 &
end
