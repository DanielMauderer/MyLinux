#!/bin/bash

# Cycle between 3 monitor setups:
#   1. w_laptop           – laptop only (no external monitors)
#   2. w_laptop_1Monitor  – home (laptop + HDMI)
#   3. w_laptop_2Monitors – work (2 external monitors, internal disabled)
#
# Reads the current monitor.conf to decide which config to switch to next.

CONF_DIR="${HOME}/.config/hypr/conf"

LAPTOP_ONLY="w_laptop"
SINGLE_MONITOR="w_laptop_1Monitor"
DUAL_MONITOR="w_laptop_2Monitors"

switch_to() {
    local target="$1"
    printf 'source = ~/.config/hypr/conf/monitors/%s.conf\n' "$target" > "${CONF_DIR}/monitor.conf"
    printf 'source = ~/.config/hypr/conf/workspaces/%s.conf\n' "$target" > "${CONF_DIR}/workspace.conf"
}

# Check which config is currently active and cycle to the next
if grep -q "$DUAL_MONITOR" "${CONF_DIR}/monitor.conf" 2>/dev/null; then
    # Currently on dual monitors → switch to laptop only
    switch_to "$LAPTOP_ONLY"
elif grep -q "$SINGLE_MONITOR" "${CONF_DIR}/monitor.conf" 2>/dev/null; then
    # Currently on single external monitor (home) → switch to dual monitors (work)
    switch_to "$DUAL_MONITOR"
else
    # Currently on laptop only (or unknown) → switch to single monitor (home)
    switch_to "$SINGLE_MONITOR"
fi

hyprctl reload
