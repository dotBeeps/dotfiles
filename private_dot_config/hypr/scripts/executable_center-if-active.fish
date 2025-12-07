#!/bin/fish

set specialActive (hyprctl monitors | grep -E "special workspace: (\S+) \(($argv[1])\)")
echo "$specialActive" >$HOME/.config/hypr/scripts/huh.log
if test -n "$specialActive"
    hyprctl dispatch focuswindow $argv[2]
    hyprctl dispatch resizeactive exact 80% 80%
    hyprctl dispatch centerwindow
end
