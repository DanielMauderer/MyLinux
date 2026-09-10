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

# ~/.config/fish/functions/nvm.fish
function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# ~/.config/fish/functions/nvm_find_nvmrc.fish
function nvm_find_nvmrc
  bass source ~/.nvm/nvm.sh --no-use ';' nvm_find_nvmrc
end

# ~/.config/fish/functions/load_nvm.fish
function load_nvm --on-variable="PWD"
  set -l default_node_version (nvm version default)
  set -l node_version (nvm version)
  set -l nvmrc_path (nvm_find_nvmrc)
  if test -n "$nvmrc_path"
    set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
    if test "$nvmrc_node_version" = "N/A"
      nvm install (cat $nvmrc_path)
    else if test "$nvmrc_node_version" != "$node_version"
      nvm use $nvmrc_node_version
    end
  else if test "$node_version" != "$default_node_version"
    echo "Reverting to default Node version"
    nvm use default
  end
end


# Restack the current git-spice stack and update its MRs
function update-stack --description 'Restack the current git-spice stack and update its MRs'
    if not git rev-parse --show-toplevel >/dev/null 2>&1
        echo "update-stack: not inside a git repository" >&2
        return 1
    end
    set -l repo (git rev-parse --show-toplevel)
    set -l start (git rev-parse --abbrev-ref HEAD)

    # Hooks off for the rebase only: .githooks/post-checkout rewrites POSTGRES_URL
    # and runs migrate + seed on EVERY branch switch, and a restack switches once
    # per part.
    set -l nohooks env GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=core.hooksPath GIT_CONFIG_VALUE_0=/dev/null

    # Sync BEFORE restacking. MRs land on main as squash merges, so a merged
    # branch shares no commits with what actually landed — `stack restack` happily
    # replays its originals onto main and conflicts on every hunk of a change that
    # is already there. `repo sync` asks GitLab which MRs are merged, deletes those
    # branches and re-parents their children onto main; only then is a restack
    # about real work. Ancestry alone can't see this, hence the forge query.
    echo "==> syncing with origin"
    if not $nohooks git-spice repo sync
        echo "update-stack: repo sync failed (forge auth? try `git-spice auth status`)" >&2
        return 1
    end

    # If $start was one of the merged branches, sync deleted it and left us on
    # trunk. Its children were re-parented onto trunk, so carry on from there —
    # but note that from trunk the restack and submit below widen to EVERY tracked
    # branch, not just this stack. --update-only keeps that harmless for branches
    # without an MR; a sibling stack that already has MRs would get rebased onto
    # the new main and force-pushed too. Usually what you want, occasionally not.
    set -l moved 0
    if not git show-ref --verify --quiet "refs/heads/$start"
        set moved 1
        set start (git rev-parse --abbrev-ref HEAD)
        echo "==> merged branch was deleted, continuing from $start"
    end

    echo "==> restacking $start"
    if not $nohooks git-spice stack restack
        echo "update-stack: restack stopped (conflict?). Resolve, then:" >&2
        echo "  git add -A; and $nohooks git-spice rebase continue" >&2
        echo "…then run update-stack again." >&2
        echo "  (to give up instead: $nohooks git-spice rebase abort)" >&2
        return 1
    end

    # Deliberately NOT wrapped in $nohooks: .githooks/pre-push is `git lfs pre-push`
    # and must run, or commits land whose LFS objects never reach the server.
    echo "==> updating merge requests"
    if not git-spice stack submit --update-only
        return 1
    end

    # A restack returns you to where you started, so .env normally still names the
    # right per-branch database. If something moved us, resync it once.
    set -l finish (git rev-parse --abbrev-ref HEAD)
    if test "$moved" = 1; or test "$start" != "$finish"
        echo "==> resyncing .env for $finish"
        "$repo/.githooks/post-checkout" HEAD HEAD 1
    end
end
