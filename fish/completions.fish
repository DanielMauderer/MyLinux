# Fish completions configuration
# This file contains custom completions

# Flatpak completions
complete -c fpi -a "(flatpak remote-ls --columns=app flathub | cut -f1)"
complete -c fpr -a "(flatpak list --app --columns=app | cut -f1)"

# Toolbox completions
complete -c tb -a "(toolbox list --containers | cut -d' ' -f1)"

# Git completions (these are aliases, so completions are handled by git itself)
# Systemctl completions (these are aliases, so completions are handled by systemctl itself)
