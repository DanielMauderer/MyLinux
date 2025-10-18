# Main Fish configuration file
# This file is loaded automatically by Fish

# Add local bin to PATH
set -gx PATH $PATH ~/.local/bin

# History settings
set -g fish_history_size 10000
set -g fish_history_session_id (random)

# Disable greeting
set -g fish_greeting ""

# Load additional configuration files
source ~/.config/fish/aliases.fish
source ~/.config/fish/functions.fish