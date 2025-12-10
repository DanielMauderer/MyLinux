# Fish functions configuration
# This file contains custom functions

# Function to create and enter a directory
function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

# Function to extract archives
function extract
    if test -f $argv[1]
        switch $argv[1]
            case "*.tar.bz2"
                tar xjf $argv[1]
            case "*.tar.gz"
                tar xzf $argv[1]
            case "*.bz2"
                bunzip2 $argv[1]
            case "*.rar"
                unrar x $argv[1]
            case "*.gz"
                gunzip $argv[1]
            case "*.tar"
                tar xf $argv[1]
            case "*.tbz2"
                tar xjf $argv[1]
            case "*.tgz"
                tar xzf $argv[1]
            case "*.zip"
                unzip $argv[1]
            case "*.Z"
                uncompress $argv[1]
            case "*.7z"
                7z x $argv[1]
            case "*"
                echo "don't know how to extract '$argv[1]'"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# Function to find and kill processes
function killf
    ps aux | grep -v grep | grep $argv[1] | awk '{print $2}' | xargs kill -9
end

# Function to create a backup of a file
function backup
    cp $argv[1] $argv[1].backup
    echo "Backup created: $argv[1].backup"
end

# Function to show disk usage of directories
function duh
    du -h $argv | sort -hr | head -20
end

# Function to show git status with colors
function gst
    git status --porcelain | while read -l line
        set -l statusg (echo $line | cut -c1-2)
        set -l file (echo $line | cut -c4-)
        switch $statusg
            case "??"
                echo -e "\033[31m$file\033[0m (untracked)"
            case "A "
                echo -e "\033[32m$file\033[0m (added)"
            case "M "
                echo -e "\033[33m$file\033[0m (modified)"
            case "D "
                echo -e "\033[31m$file\033[0m (deleted)"
        end
    end
end
