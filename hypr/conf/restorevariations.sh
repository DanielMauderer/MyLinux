#!/bin/bash
clear
cat <<"EOF"
   ___          __
  / _ \___ ___ / /____  _______
 / , _/ -_|_-</ __/ _ \/ __/ -_)
/_/|_|\__/___/\__/\___/_/  \__/

EOF
echo "You can restore to the default ML4W variations."
echo "PLEASE NOTE: You can reactivate to a customized variation or selection in the settings script."
echo "Your customized variation will not be overwritten or deleted."

if gum confirm "Do you want to restore all variations to the default values?"; then
    echo

    echo 'require("conf.keybindings.default")' >~/.config/hypr/conf/keybinding.lua
    echo "Hyprland keybinding.lua restored!"

    echo 'require("conf.windowrules.default")' >~/.config/hypr/conf/windowrule.lua
    echo "Hyprland windowrule.lua restored!"

    echo 'require("conf.animations.default")' >~/.config/hypr/conf/animation.lua
    echo "Hyprland animation.lua restored!"

    echo 'require("conf.decorations.default")' >~/.config/hypr/conf/decoration.lua
    echo "Hyprland decoration.lua restored!"

    echo 'require("conf.monitors.default")' >~/.config/hypr/conf/monitor.lua
    echo "Hyprland monitor.lua restored!"

    echo 'require("conf.workspaces.default")' >~/.config/hypr/conf/workspace.lua
    echo "Hyprland workspace.lua restored!"

    echo
    echo ":: Restore done!"
else
    echo ":: Restore canceled!"
    exit
fi
