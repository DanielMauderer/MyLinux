#!/bin/bash

# Toggle between "laptop only" and "2 external monitors" setups.
# Reads the current monitor.conf to decide which config to switch to.

CONF_DIR="${HOME}/.config/hypr/conf"

DUAL_MONITOR="w_laptop_2Monitors"
LAPTOP_ONLY="w_laptop"

# Check which config is currently active
if grep -q "$DUAL_MONITOR" "${CONF_DIR}/monitor.conf" 2>/dev/null; then
    # Currently on dual monitors → switch to laptop only
    printf 'source = ~/.config/hypr/conf/monitors/%s.conf\n' "$LAPTOP_ONLY" > "${CONF_DIR}/monitor.conf"
    printf 'source = ~/.config/hypr/conf/workspaces/%s.conf\n' "$LAPTOP_ONLY" > "${CONF_DIR}/workspace.conf"
else
    # Currently on laptop only → switch to dual monitors
    printf 'source = ~/.config/hypr/conf/monitors/%s.conf\n' "$DUAL_MONITOR" > "${CONF_DIR}/monitor.conf"
    printf 'source = ~/.config/hypr/conf/workspaces/%s.conf\n' "$DUAL_MONITOR" > "${CONF_DIR}/workspace.conf"
fi

hyprctl reload
