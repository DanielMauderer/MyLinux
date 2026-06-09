# Personal Context

## User
- Name: Daniel Mauderer
- Role: Software developer

## System
- OS: Fedora Silverblue (immutable — base OS is read-only)
- Desktop: Hyprland on Wayland
- Shell: Fish
- Terminal: Kitty

## Package Management
- **Do NOT suggest `dnf install`** for the host system — it won't persist on Silverblue
- Host-level packages: `rpm-ostree install` (requires reboot)
- GUI apps: Flatpak (`flatpak install`)
- CLI tools: Homebrew (`brew install`) or Cargo (`cargo install`) — prefer these over toolbox for new tools
- Toolbox container `dev-tools` exists for isolated dev environments (`toolbox run -c dev-tools <cmd>` or `tbr <cmd>`)

## Dev Environment
- Editor: Neovim (config in `~/.config/nvim/`, lazy.nvim plugin manager)
- Version control UI: Neogit / fugitive inside Neovim
- Rust watcher: `bacon` (run in a split or via `cw` alias)
- Containers: Podman (aliased as `docker`)
- Primary language: Rust

## Workflow Preferences
- Keep suggestions concise — no hand-holding on standard tools
- Prefer Fish-compatible shell syntax in examples
- When suggesting installs, use brew or cargo first
