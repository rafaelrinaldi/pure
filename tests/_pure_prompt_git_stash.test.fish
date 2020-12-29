source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_set_color.fish
source $current_dirname/../functions/_pure_prompt_git_stash.fish
@mesg (_print_filename $current_filename)


function setup
    _purge_configs
    _disable_colors
    mkdir -p /tmp/pure_pure_prompt_git_stash
    and cd /tmp/pure_pure_prompt_git_stash

    git init --quiet
    git config --local user.email "you@example.com"
    git config --local user.name "Your Name"
end

function teardown
    rm -rf /tmp/pure_pure_prompt_git_stash
end

@test "_pure_prompt_git_stash: no indicator when no stash" (
    set --global pure_symbol_git_stash '≡'
    touch init.file
    git add init.file
    git commit --quiet --message 'mandatory initial commit'

    _pure_prompt_git_stash
) = $EMPTY

@test "_pure_prompt_git_stash: stashing file shows indicator" (
    set --global pure_symbol_git_stash '≡'
    touch init.file stash.file
    git add init.file
    git commit --quiet --message 'mandatory initial commit'
    git add stash.file
    git stash --quiet

    _pure_prompt_git_stash
) = ' ≡'

@test "_pure_prompt_git_stash: symbol is colorized" (
    set --global pure_symbol_git_stash '≡'
    set --global pure_color_git_stash cyan
    touch init.file stash.file
    git add init.file
    git commit --quiet --message 'mandatory initial commit'
    git add stash.file
    git stash --quiet

    _pure_prompt_git_stash
) = (set_color cyan)' ≡'

