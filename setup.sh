#!/bin/bash

# Fish shell setup script for Fedora Silverblue
# This script handles both initial installation and updates

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${CYAN}================================${NC}"
    echo -e "${CYAN}  Fish Shell Setup for Silverblue${NC}"
    echo -e "${CYAN}================================${NC}"
    echo ""
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    print_error "This script should not be run as root"
    exit 1
fi

# Check if we're on Silverblue
if ! command -v rpm-ostree &> /dev/null; then
    print_error "This script is designed for Fedora Silverblue"
    exit 1
fi

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    local name="$3"
    
    if [[ -L "$target" ]]; then
        print_status "Updating existing $name symlink..."
        rm "$target"
    elif [[ -d "$target" || -f "$target" ]]; then
        print_status "Backing up existing $name configuration..."
        mv "$target" "$target.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    ln -sf "$source" "$target"
    print_success "$name configuration linked"
}

# Get the absolute path of the current directory
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Link Fish configuration
print_status "Setting up Fish configuration..."
mkdir -p ~/.config/fish
create_symlink "$REPO_DIR/fish/config.fish" "$HOME/.config/fish/config.fish" "Fish config"
create_symlink "$REPO_DIR/fish/aliases.fish" "$HOME/.config/fish/aliases.fish" "Fish aliases"
create_symlink "$REPO_DIR/fish/functions.fish" "$HOME/.config/fish/functions.fish" "Fish functions"
create_symlink "$REPO_DIR/fish/completions.fish" "$HOME/.config/fish/completions.fish" "Fish completions"
create_symlink "$REPO_DIR/fish/fish_plugins" "$HOME/.config/fish/fish_plugins" "Fish plugins"

# Link Hyprland configuration
print_status "Setting up Hyprland configuration..."
create_symlink "$REPO_DIR/hypr" "$HOME/.config/hypr" "Hyprland"

# Link Waybar configuration
print_status "Setting up Waybar configuration..."
create_symlink "$REPO_DIR/waybar" "$HOME/.config/waybar" "Waybar"

# Link Fastfetch configuration
print_status "Setting up Fastfetch configuration..."
create_symlink "$REPO_DIR/fastfetch" "$HOME/.config/fastfetch" "Fastfetch"

# Link SwayBackground configuration
print_status "Setting up SwayBackground configuration..."
create_symlink "$REPO_DIR/swaybg" "$HOME/.config/swaybg" "SwayBackground"

# Link Dunst configuration
print_status "Setting up Dunst configuration..."
create_symlink "$REPO_DIR/dunst" "$HOME/.config/dunst" "Dunst"

# Link kitty configuration
print_status "Setting up Kitty configuration..."
create_symlink "$REPO_DIR/kitty" "$HOME/.config/kitty" "Kitty"

# Link wlogout configuration
print_status "Setting up Wlogout configuration..."
create_symlink "$REPO_DIR/wlogout" "$HOME/.config/wlogout" "Wlogout"
create_symlink "$REPO_DIR/matugen" "$HOME/.config/matugen" "Matugen"

print_success "All configuration directories linked"

print_status "Installing Hyprshot..."
rm -rf $REPO_DIR/Hyprshot
git clone https://github.com/Gustash/hyprshot.git $REPO_DIR/Hyprshot
mv $REPO_DIR/Hyprshot/hyprshot $HOME/.local/bin/hyprshot
chmod +x $HOME/.local/bin/hyprshot

# Set up toolbox container with command line tools
print_status "Setting up toolbox container with command line tools..."
if toolbox list | grep -q "dev-tools"; then
    print_status "Toolbox container 'dev-tools' already exists, updating..."
else
    print_status "Creating new toolbox container 'dev-tools'..."
    toolbox create --image fedora-toolbox:latest dev-tools
fi

toolbox run -c dev-tools sudo dnf install -y cargo bat fd-find ripgrep fzf tree btop fish
toolbox run -c dev-tools cargo install eza
toolbox run -c dev-tools cargo install matugen
toolbox run -c dev-tools fish -c "fish_add_path ~/.cargo/bin"

# Install fisher and plugins (including Tide prompt)
print_status "Installing fisher and Tide prompt..."
curl -sL https://git.io/fisher | source; 
fisher install jorgebucaran/fisher; 
fisher update;
fisher install IlanCosman/tide@v6;

# Ensure scripts are executable
print_status "Ensuring Hypr scripts are executable..."
chmod +x "$HOME/.config/hypr/scripts/"*.sh 2>/dev/null || true


print_success "Toolbox container with command line tools ready"

# Check for pending updates
print_status "Checking for pending system updates..."
if rpm-ostree status | grep -q "pending"; then
    print_warning "System has pending updates. You may want to run 'rpm-ostree upgrade' and reboot."
fi

# Final status
echo ""
print_success "Setup completed successfully!"
echo ""
echo "📋 Summary:"
echo "  • Command line tools: Installed in toolbox container"
echo "  • Fish config: Linked to ~/.config/fish/"
echo "  • Hyprland config: Linked to ~/.config/hypr/"
echo "  • Waybar config: Linked to ~/.config/waybar/"
echo "  • Fastfetch config: Linked to ~/.config/fastfetch/"
echo "  • Toolbox container: Ready with eza, bat, fd, ripgrep, fzf, tree, btop, neofetch"
echo ""
echo "🔧 Available aliases:"
echo "  • c, ff, ls, ll, lt, shutdown, wifi"
echo "  • update, reboot, suspend, hibernate"
echo "  • tb, tbr (toolbox commands)"
echo "  • fp, fpi, fpu, fpr, fpl (flatpak commands)"
echo "  • gs, ga, gc, gp, gl (git commands)"
echo "  • top (btop), cat (bat), less (bat), more (bat), tree, fd, rg, fzf, neofetch (via toolbox)"
echo ""

echo ""
print_status "Run this script again anytime to update your configuration!"
echo ""
print_status "Configuration directories are now symlinked to this repository:"
echo "  • ~/.config/fish/ → $REPO_DIR/fish/"
echo "  • ~/.config/hypr/ → $REPO_DIR/hypr/"
echo "  • ~/.config/waybar/ → $REPO_DIR/waybar/"
echo "  • ~/.config/fastfetch/ → $REPO_DIR/fastfetch/"
echo "  • ~/.config/wlogout/ → $REPO_DIR/wlogout/"
echo ""
print_status "Any changes you make to the repository will be reflected in your system!"
