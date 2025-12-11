#!/usr/bin/env bash

set -euo pipefail

# Derive Material colors using Matugen from the current wallpaper, then
# generate theme files for Waybar, Wlogout, Kitty, Dunst, and Swaylock from Hypr colors.
#
# Usage:
#   apply_matugen.sh [WALLPAPER_PATH]
#
# If WALLPAPER_PATH is not provided, defaults to Hypr cache wallpaper.

WALLPAPER="${1:-$HOME/.config/hypr/cache/current_wallpaper.png}"
HYPR_COLORS="$HOME/.config/hypr/colors.conf"
WAYBAR_MATUGEN="$HOME/.config/waybar/matugen.css"
WLOGOUT_MATUGEN="$HOME/.config/wlogout/matugen.css"
KITTY_COLORS="$HOME/.config/kitty/colors.conf"
DUNST_COLORS="$HOME/.config/dunst/colors.conf"
SWAYLOCK_CONFIG="$HOME/.config/swaylock/config"

log() {
    printf "[matugen] %s\n" "$*" >&2
}

hex_from_rgba_line() {
    # Input: a line like `$primary = rgba(abc7ffff)`
    # Output: #RRGGBB (strip alpha)
    local line="$1"
    local raw
    raw="$(sed -nE 's/.*rgba\(([0-9a-fA-F]{8})\).*/\1/p' <<< "$line" | tr '[:upper:]' '[:lower:]')"
    if [[ -n "$raw" ]]; then
        printf "#%s\n" "${raw:0:6}"
    fi
}

hex_from_rgba_line_no_hash() {
    # Input: a line like `$primary = rgba(abc7ffff)`
    # Output: RRGGBB (no hash, for swaylock)
    local line="$1"
    local raw
    raw="$(sed -nE 's/.*rgba\(([0-9a-fA-F]{8})\).*/\1/p' <<< "$line" | tr '[:upper:]' '[:lower:]')"
    if [[ -n "$raw" ]]; then
        printf "%s\n" "${raw:0:6}"
    fi
}

extract_color() {
    # $1 variable name without leading $
    local var="$1"
    local line
    line="$(grep -E "^\$${var}[[:space:]]*=" "$HYPR_COLORS" || true)"
    if [[ -z "$line" ]]; then
        echo ""
        return 0
    fi
    hex_from_rgba_line "$line"
}

extract_color_no_hash() {
    # $1 variable name without leading $
    # Output: RRGGBB (no hash, for swaylock)
    local var="$1"
    local line
    line="$(grep -E "^\$${var}[[:space:]]*=" "$HYPR_COLORS" || true)"
    if [[ -z "$line" ]]; then
        echo ""
        return 0
    fi
    hex_from_rgba_line_no_hash "$line"
}

ensure_hypr_colors() {
    if [[ ! -f "$HYPR_COLORS" ]]; then
        log "Missing $HYPR_COLORS; creating empty placeholder."
        mkdir -p "$(dirname "$HYPR_COLORS")"
        : > "$HYPR_COLORS"
    fi

    if command -v matugen >/dev/null 2>&1 && [[ -f "$WALLPAPER" ]]; then
        log "Running matugen with templates on: $WALLPAPER"
        if ! matugen image "$WALLPAPER"; then
            log "Matugen invocation failed; continuing with existing theme files"
        fi
    else
        log "matugen not available or wallpaper missing; using existing $HYPR_COLORS"
    fi
}

generate_waybar_css() {
    local text subtext1 subtext0 base mantle crust mauve red sky green overlay2 overlay1 overlay0
    text="$(extract_color on_surface)"
    subtext1="$(extract_color on_surface_variant)"
    subtext0="$(extract_color outline)"
    base="$(extract_color surface)"
    mantle="$(extract_color surface_container_high)"
    crust="$(extract_color surface_container_lowest)"
    mauve="$(extract_color primary)"
    red="$(extract_color error)"
    sky="$(extract_color secondary)"
    green="$(extract_color tertiary)"
    overlay2="$(extract_color surface_container_highest)"
    overlay1="$(extract_color surface_container_high)"
    overlay0="$(extract_color surface_container)"
    rm -rf "$WAYBAR_MATUGEN"
    mkdir -p "$(dirname "$WAYBAR_MATUGEN")"
    cat > "$WAYBAR_MATUGEN" <<EOF
@define-color text ${text:-#e2e2e9};
@define-color subtext1 ${subtext1:-#c4c6d0};
@define-color subtext0 ${subtext0:-#8e9099};
@define-color overlay2 ${overlay2:-#33353a};
@define-color overlay1 ${overlay1:-#282a2f};
@define-color overlay0 ${overlay0:-#1e2025};
@define-color base ${base:-#111318};
@define-color mantle ${mantle:-#282a2f};
@define-color crust ${crust:-#0c0e13};
@define-color mauve ${mauve:-#abc7ff};
@define-color red ${red:-#ffb4ab};
@define-color sky ${sky:-#bec6dc};
@define-color green ${green:-#ddbce0};
EOF
}

generate_wlogout_css() {
    # Reuse same mapping as Waybar
    cp -f "$WAYBAR_MATUGEN" "$WLOGOUT_MATUGEN"
}

generate_kitty_colors() {
    local fg bg pri sec ter err
    fg="$(extract_color on_surface)"
    bg="$(extract_color surface)"
    pri="$(extract_color primary)"
    sec="$(extract_color secondary)"
    ter="$(extract_color tertiary)"
    err="$(extract_color error)"
    rm -rf "$KITTY_COLORS"
    mkdir -p "$(dirname "$KITTY_COLORS")"
    cat > "$KITTY_COLORS" <<EOF
foreground ${fg:-#e2e2e9}
background ${bg:-#111318}
cursor ${pri:-#abc7ff}
selection_background ${pri:-#abc7ff}
selection_foreground ${bg:-#111318}

# Basic 16-color palette (rough mapping)
color0  ${bg:-#111318}
color7  ${fg:-#e2e2e9}
color8  ${bg:-#111318}
color15 ${fg:-#e2e2e9}
color1  ${err:-#ffb4ab}
color9  ${err:-#ffb4ab}
color2  ${ter:-#ddbce0}
color10 ${ter:-#ddbce0}
color3  ${sec:-#bec6dc}
color11 ${sec:-#bec6dc}
color4  ${pri:-#abc7ff}
color12 ${pri:-#abc7ff}
color5  ${ter:-#ddbce0}
color13 ${ter:-#ddbce0}
color6  ${sec:-#bec6dc}
color14 ${sec:-#bec6dc}
EOF
}

generate_dunst_colors() {
    local base text sub1 err pri
    base="$(extract_color surface)"
    text="$(extract_color on_surface)"
    sub1="$(extract_color on_surface_variant)"
    err="$(extract_color error)"
    pri="$(extract_color primary)"
    rm -rf "$DUNST_COLORS"
    mkdir -p "$(dirname "$DUNST_COLORS")"
    cat > "$DUNST_COLORS" <<EOF
[urgency_low]
background = "${base:-#111318}CC"
foreground = "${sub1:-#c4c6d0}"

[urgency_normal]
background = "${base:-#111318}CC"
foreground = "${text:-#e2e2e9}"

[urgency_critical]
background = "${err:-#ffb4ab}CC"
foreground = "${base:-#111318}"
frame_color = "${pri:-#abc7ff}"
EOF
}

generate_swaylock_config() {
    local surface on_surface on_error primary secondary error outline
    surface="$(extract_color_no_hash surface)"
    on_surface="$(extract_color_no_hash on_surface)"
    on_error="$(extract_color_no_hash on_error)"
    primary="$(extract_color_no_hash primary)"
    secondary="$(extract_color_no_hash secondary)"
    error="$(extract_color_no_hash error)"
    outline="$(extract_color_no_hash outline)"
    
    rm -rf "$SWAYLOCK_CONFIG"
    mkdir -p "$(dirname "$SWAYLOCK_CONFIG")"
    cat > "$SWAYLOCK_CONFIG" <<EOF
# Swaylock configuration generated by Matugen
# Background image from Hypr cache
image=$WALLPAPER

# Background color (fallback if image fails)
color=${surface:-111318}

# Ring colors
ring-color=${primary:-abc7ff}80
inside-color=${surface:-111318}80

# Text colors
text-color=${on_surface:-e2e2e9}
text-clear-color=${on_surface:-e2e2e9}
text-ver-color=${on_surface:-e2e2e9}
text-wrong-color=${on_error:-690005}

# Key highlight colors
key-hl-color=${primary:-abc7ff}
bs-hl-color=${error:-ffb4ab}
caps-lock-key-hl-color=${secondary:-bec6dc}

# Separator color
separator-color=${outline:-8e9099}80

# Line color
line-color=${outline:-8e9099}80

# Verification state colors
inside-ver-color=${primary:-abc7ff}40
ring-ver-color=${primary:-abc7ff}

# Wrong state colors
inside-wrong-color=${error:-ffb4ab}40
ring-wrong-color=${error:-ffb4ab}

# Clear state colors
inside-clear-color=${secondary:-bec6dc}40
ring-clear-color=${secondary:-bec6dc}

# Layout options
indicator-radius=120
indicator-thickness=7
ring-radius=120
font=sans-serif
clock-font-size=14
grace=0
grace-no-mouse
grace-no-touch
fade-in=0.1
EOF
}

reload_apps() {
    # Waybar: reload style/config
    pkill -USR2 waybar 2>/dev/null || true
    # Dunst: reload
    command -v dunstctl >/dev/null 2>&1 && dunstctl reload || true
    # Hyprland: reload to pick color vars
    command -v hyprctl >/dev/null 2>&1 && hyprctl reload || true
    # Kitty: apply colors to running instances when possible
    if command -v kitty >/dev/null 2>&1; then
        kitty @ set-colors -a "$KITTY_COLORS" >/dev/null 2>&1 || true
    fi
}

main() {
    ensure_hypr_colors
    reload_apps
    log "Applied Matugen-derived colors."
}

main "$@"


