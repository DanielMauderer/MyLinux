# Fish aliases configuration
# This file contains all command aliases

# Basic commands
alias c='clear'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias wifi='nmtui'
# Cleanup alias removed - script not available

alias docker='podman'
alias nf='npm run format'
alias nl='npm run lint'
alias nt='npm run test'

# System management
alias update='rpm-ostree upgrade'
alias reboot='systemctl reboot'
alias suspend='systemctl suspend'
alias hibernate='systemctl hibernate'

# Toolbox aliases
alias tb='SHELL=/usr/bin/fish toolbox enter'
alias tbr='SHELL=/usr/bin/fish toolbox run'

# Flatpak aliases
alias fp='flatpak'
alias fpi='flatpak install'
alias fpu='flatpak update'
alias fpr='flatpak remove'
alias fpl='flatpak list'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git checkout'
alias gp='git push'
alias gl='git log --oneline'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Additional useful aliases (using toolbox for tools not available in Silverblue)
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps aux'
alias top='btop'
alias cat='bat'
alias less='bat'
alias more='bat'
alias tree='tree'
alias fd='fd'
alias rg='rg'
alias fzf='fzf'
