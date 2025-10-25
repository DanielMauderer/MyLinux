# Fish aliases configuration
# This file contains all command aliases

# Basic commands
alias c='clear'
alias ff='fastfetch'
alias ls='toolbox run -c dev-tools /var/home/$USER/.cargo/bin/eza -a --icons=always'
alias ll='toolbox run -c dev-tools /var/home/$USER/.cargo/bin/eza -al --icons=always'
alias lt='toolbox run -c dev-tools /var/home/$USER/.cargo/bin/eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias wifi='nmtui'
# Cleanup alias removed - script not available

# System management
alias update='rpm-ostree upgrade'
alias reboot='systemctl reboot'
alias suspend='systemctl suspend'
alias hibernate='systemctl hibernate'

# Toolbox aliases
alias tb='toolbox enter'
alias tbr='toolbox run'

# Flatpak aliases
alias fp='flatpak'
alias fpi='flatpak install'
alias fpu='flatpak update'
alias fpr='flatpak remove'
alias fpl='flatpak list'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
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
alias top='toolbox run -c dev-tools btop'
alias cat='toolbox run -c dev-tools bat'
alias less='toolbox run -c dev-tools bat'
alias more='toolbox run -c dev-tools bat'
alias tree='toolbox run -c dev-tools tree'
alias fd='toolbox run -c dev-tools fd'
alias rg='toolbox run -c dev-tools rg'
alias fzf='toolbox run -c dev-tools fzf'
alias neofetch='toolbox run -c dev-tools neofetch'
