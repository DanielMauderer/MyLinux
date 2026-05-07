# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for a Hyprland-based Wayland desktop on **Fedora Silverblue** (an immutable OS). All config directories are symlinked from this repo into `~/.config/` via `setup.sh`. The system is designed around Material You dynamic theming via **matugen**, which generates color palettes from the current wallpaper.

## Setup / Deployment

```bash
# Initial setup or re-link all config dirs
./setup.sh
```

This symlinks every top-level directory (fish, hypr, waybar, kitty, etc.) into `~/.config/`. It also installs tools into a **toolbox container** called `dev-tools` (because Silverblue's base OS is immutable — user-space tools go in toolbox or flatpak).

System updates use `rpm-ostree upgrade` (not `dnf`). Flatpak is the primary app install mechanism.

## Theming Architecture

The entire color system is driven by **matugen** extracting a Material You palette from the wallpaper at `~/.config/hypr/cache/current_wallpaper.png`.

**Flow:**
1. `hypr/scripts/apply_matugen.sh [WALLPAPER_PATH]` — runs `matugen image <wallpaper>` using templates in `matugen/templates/`, then reloads all apps
2. Matugen writes to: `hypr/colors.conf` (Hyprland vars), `waybar/matugen.css`, `wlogout/matugen.css`, `kitty/colors.conf`, `dunst/dunstrc`, `rofi/colors.rasi`
3. Each app's style imports the generated file alongside a static `mocha.css` or base config

**Key color variables** (from `hypr/colors.conf`, in `rgba(RRGGBBAA)` format):
- `$primary`, `$secondary`, `$tertiary`, `$error`
- `$surface`, `$on_surface`, `$on_surface_variant`, `$outline`
- `$surface_container`, `$surface_container_high`, etc.

When editing theme templates, variables are referenced as `{{colors.primary.default.hex}}` in `.tmpl` files, or extracted via `apply_matugen.sh`'s `extract_color` functions for apps that don't use matugen's template engine directly.

## Hyprland Configuration

`hypr/hyprland.conf` is the entry point — it sources modular config files from `hypr/conf/`:

| File | Purpose |
|------|---------|
| `monitor.conf` | Monitor layout (sourced from `monitors/`) |
| `workspace.conf` | Workspace rules (sourced from `workspaces/`) |
| `keybinding.conf` | Sources `keybindings/default.conf` |
| `decoration.conf` / `animation.conf` | Visual effects |
| `windowrule.conf` | App-specific window rules |
| `focus-mode-rules.conf` | Rules for focus/zen mode |

**Key scripts** in `hypr/scripts/`:
- `apply_matugen.sh` — theme application (run after changing wallpaper)
- `monitor-hotplug.sh` — toggle between single/multi-monitor layouts
- `focus-mode.sh` — zen mode (hides waybar, removes gaps on active workspace)
- `power.sh` — power management actions

**Key bindings** (SUPER = main modifier):
- `SUPER+RETURN` → kitty terminal
- `SUPER+SPACE` → rofi launcher
- `SUPER+L` → swaylock
- `SUPER+S` → region screenshot to clipboard (hyprshot)
- `SUPER+Z` → toggle focus mode
- `SUPER+SHIFT+=` → toggle monitor hotplug

## Waybar

`waybar/config.jsonc` is the main config. Modules are split into individual files under `waybar/modules/`. Layouts live in `waybar/layouts/`.

Styling: `waybar/style.css` imports `waybar/matugen.css` (generated colors) and `waybar/mocha.css` (static Catppuccin base). Reload with `pkill -USR2 waybar`.

## Fish Shell

- `fish/config.fish` — sources `aliases.fish` and `functions.fish`
- `fish/aliases.fish` — all aliases (key ones: `ls`→eza, `cat`→bat, `docker`→podman, `tb`→toolbox enter)
- `fish/functions.fish` — custom functions (`mkcd`, `extract`, `killf`, `gst`, etc.)
- `fish/fish_plugins` — Fisher plugin list (Tide prompt, nvm, etc.)
- `fish/conf.d/` — auto-sourced configs (e.g., `rustup.fish`)

Toolbox commands: `tb` enters the `dev-tools` container, `tbr <cmd>` runs a command in it. CLI tools like `eza`, `bat`, `matugen` live in the toolbox's cargo bin.

## Neovim

Entry point: `nvim/init.lua`. Plugin manager: **lazy.nvim** (plugins defined in `nvim/lua/plugins/`).

Notable behaviors:
- YAML files inside Helm charts auto-detect as `helm` filetype (checks parent dirs for `Chart.yaml`)
- Kitty padding is set to 0 on `VimEnter` and restored to 10 on `VimLeave`
- Custom `LspManager` command opens an LSP picker (`nvim/lua/lsp-manager.lua`)
- Leader key: `<Space>`

## Adding/Changing Configs

- **New app config**: Add directory here, add a `create_symlink` call in `setup.sh`, re-run `./setup.sh`
- **Theme a new app**: Add a template to `matugen/templates/` and register it in `matugen/config.toml`
- **New Hyprland keybinding**: Edit `hypr/conf/keybindings/default.conf`; reload with `SUPER+CTRL+R`
- **New Waybar module**: Add `.jsonc` in `waybar/modules/`, reference it in `waybar/config.jsonc`
