function fnx --wraps='npx nx run (nx-launcher | fzf)' --wraps='npx nx run (/var/home/maudi/git/fork/nx-launcher/target/release/nx-launcher | fzf)' --description 'alias fnx npx nx run (/var/home/maudi/git/fork/nx-launcher/target/release/nx-launcher | fzf)'
    npx nx run (/var/home/maudi/git/fork/nx-launcher/target/release/nx-launcher | fzf) $argv
end
