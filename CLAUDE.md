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

### Plugins

**Colorscheme & UI**
| Plugin | Description |
|--------|-------------|
| `ember-theme/nvim` | Active colorscheme (ember) |
| `nvim-lualine/lualine.nvim` | Statusline |
| `folke/which-key.nvim` | Shows pending keybind hints on leader press |
| `folke/snacks.nvim` | Multi-purpose: fuzzy pickers, notifications, statuscolumn, bigfile handling, quickfile, file rename |
| `j-hui/fidget.nvim` | LSP progress spinner in bottom-right corner |

**LSP & Completion**
| Plugin | Description |
|--------|-------------|
| `neovim/nvim-lspconfig` | LSP configuration — servers: `lua_ls`, `gopls`, `clangd`, `html`, `cssls`, `jsonls`, `yamlls` (rust_analyzer managed by rustaceanvim) |
| `williamboman/mason.nvim` | LSP/tool installer UI (`:Mason`) |
| `williamboman/mason-lspconfig.nvim` | Bridges Mason with lspconfig |
| `WhoIsSethDaniel/mason-tool-installer.nvim` | Auto-installs formatters/linters: stylua, prettierd, isort, ruff, gofumpt, clang-format |
| `saghen/blink.cmp` | Completion engine (sources: LSP, path, snippets, buffer) |
| `L3MON4D3/LuaSnip` | Snippet engine (dependency of blink.cmp) |
| `Fildo7525/pretty_hover` | Prettier hover documentation popup |
| `b0o/schemastore.nvim` | JSON/YAML schema store for jsonls/yamlls |
| `folke/neodev.nvim` | Neovim Lua API completions for editing configs |
| `rachartier/tiny-code-action.nvim` | LSP code actions with diff preview (`<leader>ca`) |

**Rust**
| Plugin | Description |
|--------|-------------|
| `mrcjkb/rustaceanvim` | Enhanced rust_analyzer integration — runnables (`<leader>cr`), debuggables (`<leader>cD`), expand macro (`<leader>cE`), explain error (`<leader>ce`) |
| `saecki/crates.nvim` | Cargo.toml crate version management — show versions (`<leader>cv`), upgrade crate (`<leader>cu`), upgrade all (`<leader>cU`); completions via blink.cmp in toml files |

**Treesitter**
| Plugin | Description |
|--------|-------------|
| `nvim-treesitter/nvim-treesitter` | Syntax highlighting, indentation, and text objects (bash, c, rust, ts, js, lua, html, css, etc.) |
| `stevearc/aerial.nvim` | Code outline/symbol tree picker (`<leader>fa`) |

**Formatting**
| Plugin | Description |
|--------|-------------|
| `stevearc/conform.nvim` | Formatter dispatcher — lua:stylua, python:isort+ruff, rust:rustfmt, js/ts:prettierd, json:jq, sql:sqruff/sqlfluff (`<leader>fo`, `<leader>fs` for SQL) |

**Debugging (DAP)**
| Plugin | Description |
|--------|-------------|
| `mfussenegger/nvim-dap` | Debug Adapter Protocol core — configs for C/C++/Rust (gdb) and TypeScript/JavaScript (js-debug-adapter) |
| `rcarriga/nvim-dap-ui` | DAP UI (auto-opens on debug start; F5 continue, F10 step over, F11 step in, F12 step out, `<leader>du` toggle) |
| `theHamsta/nvim-dap-virtual-text` | Shows variable values inline while debugging |
| `jay-babu/mason-nvim-dap.nvim` | Auto-installs DAP adapters (cppdbg, js-debug-adapter) via Mason |
| `Weissle/persistent-breakpoints.nvim` | Persists breakpoints across sessions (`<leader>db` toggle, `<leader>dB` conditional, `<leader>dc` clear) |

**Git**
| Plugin | Description |
|--------|-------------|
| `tpope/vim-fugitive` | Git commands inside Neovim (`:G`, `:Gdiff`, etc.) |
| `tpope/vim-rhubarb` | GitHub integration for fugitive (`:GBrowse`) |
| `lewis6991/gitsigns.nvim` | Git hunks in gutter; stage/reset/blame/diff hunks (`<leader>h*`, `]c`/`[c` to navigate) |
| `NeogitOrg/neogit` | Magit-like interactive Git UI (`<leader>gg` open, `<leader>gp` pull --rebase) |
| `harrisoncramer/gitlab.nvim` | GitLab MR review and comment integration |
| `sindrets/diffview.nvim` | Diff viewer (dependency of neogit and gitlab.nvim) |

**File Navigation**
| Plugin | Description |
|--------|-------------|
| `nvim-neo-tree/neo-tree.nvim` | File tree sidebar (`<leader>tt` toggle, `<leader>tT` float, `<leader>tg` git status, `<leader>tb` buffers) |
| `stevearc/oil.nvim` | Edit the filesystem like a buffer |
| `dmtrKovalenko/fff.nvim` | Fast Rust-powered file picker (`<leader>ff` from cwd, `<leader>Ff` from git root) |
| `ibhagwan/fzf-lua` | fzf-based pickers: registers (`<leader>sr`), zoxide jump (`<leader>z`), ripgrep in dir (`<leader>Rg`) |
| `junegunn/fzf` + `fzf.vim` | Base fzf binary and Vim commands |

**Search & Replace**
| Plugin | Description |
|--------|-------------|
| `MagicDuck/grug-far.nvim` | Find-and-replace UI with regex support (`:GrugFar`) |

**Diagnostics**
| Plugin | Description |
|--------|-------------|
| `folke/trouble.nvim` | Diagnostics list panel (`<leader>xx` all, `<leader>xX` buffer errors, `<leader>cs` symbols, `<leader>cl` LSP refs) |

**Editing Utilities**
| Plugin | Description |
|--------|-------------|
| `numToStr/Comment.nvim` | `gc` to comment/uncomment visual regions or lines |
| `windwp/nvim-autopairs` | Auto-closes brackets, quotes, and parens in insert mode |
| `kylechui/nvim-surround` | Add/change/delete surrounding characters (brackets, quotes, HTML tags) |
| `chrisgrieser/nvim-origami` | Enhanced code folding with folded-line count display |
| `tpope/vim-sleuth` | Auto-detects `tabstop` and `shiftwidth` from file context |

**HTTP & APIs**
| Plugin | Description |
|--------|-------------|
| `mistweaverco/kulala.nvim` | HTTP client for `.http`/`.rest` files (`<leader>ks` send, `<leader>ka` send all, `<leader>kb` scratchpad) |

**Project Management**
| Plugin | Description |
|--------|-------------|
| `letieu/jira.nvim` | Jira issue browser inside Neovim (active sprint, backlog, JQL queries) |
| `linux-cultist/venv-selector.nvim` | Python virtual environment selector (`,v`; only loads for Python files) |

**Notes**
| Plugin | Description |
|--------|-------------|
| `epwalsh/obsidian.nvim` | Obsidian vault integration for markdown (loads only if `~/Cloud/Obsidian` exists) |

**Fun**
| Plugin | Description |
|--------|-------------|
| `nvzone/typr` | Typing speed practice game (`:Typr`, `:TyprStats`) |

## Adding/Changing Configs

- **New app config**: Add directory here, add a `create_symlink` call in `setup.sh`, re-run `./setup.sh`
- **Theme a new app**: Add a template to `matugen/templates/` and register it in `matugen/config.toml`
- **New Hyprland keybinding**: Edit `hypr/conf/keybindings/default.conf`; reload with `SUPER+CTRL+R`
- **New Waybar module**: Add `.jsonc` in `waybar/modules/`, reference it in `waybar/config.jsonc`
