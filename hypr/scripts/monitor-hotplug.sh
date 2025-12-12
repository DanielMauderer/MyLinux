#!/bin/bash

# External monitor names
HDMI=HDMI-A-1
DP=DP-1

# Check if both HDMI-A-1 and DP-1 are connected
HDMI_CONNECTED=$(hyprctl monitors | grep -c "$HDMI" || true)
DP_CONNECTED=$(hyprctl monitors | grep -c "$DP" || true)

# Workspace config directory
CONF_DIR="${HOME}/.config/hypr/conf"

# Check if both HDMI-A-1 and DP-1 are connected
if [ "$HDMI_CONNECTED" -gt 0 ] && [ "$DP_CONNECTED" -gt 0 ]; then
    # Both external monitors connected → switch to 2-monitor configs
    printf 'source = ~/.config/hypr/conf/workspaces/w_laptop_2Monitors.conf\n' > "${CONF_DIR}/workspace.conf"
    printf 'source = ~/.config/hypr/conf/monitors/w_laptop_2Monitors.conf\n' > "${CONF_DIR}/monitor.conf"
    if command -v hyprctl >/dev/null 2>&1; then
        hyprctl reload || true
    fi
else
    # Revert to default configs
    printf 'source = ~/.config/hypr/conf/workspaces/w_laptop.conf\n' > "${CONF_DIR}/workspace.conf"
    printf 'source = ~/.config/hypr/conf/monitors/w_laptop.conf\n' > "${CONF_DIR}/monitor.conf"
    if command -v hyprctl >/dev/null 2>&1; then
        hyprctl reload || true
    fi
fi