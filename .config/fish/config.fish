# Fish shell configuration
# Minimal configuration with essential settings

# Set default editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Disable greeting message
set -g fish_greeting ""

# Load aliases
if test -f "$HOME/.config/fish/aliases.fish"
    source "$HOME/.config/fish/aliases.fish"
end
