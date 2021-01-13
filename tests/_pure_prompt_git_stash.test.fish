source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_prompt_git_stash.fish
@echo (_print_filename (status filename))


function setup
    mkdir -p /tmp/pure_pure_prompt_git_stash
    and cd /tmp/pure_pure_prompt_git_stash

    git init --quiet
    git config --local user.email "you@example.com"
    git config --local user.name "Your Name"

    _purge_configs
    _disable_colors
end

function teardown
    rm -rf /tmp/pure_pure_prompt_git_stash
end

@test "_pure_prompt_git_stash: no indicator when no stash" (
    set --universal pure_symbol_git_stash '≡'
    touch init.file
    git add init.file
    git commit --quiet --message 'mandatory initial commit'

    _pure_prompt_git_stash
) = $EMPTY

@test "_pure_prompt_git_stash: stashing file shows indicator" (
    set --universal pure_symbol_git_stash '≡'
    touch init.file stash.file
    git add init.file
    git commit --quiet --message 'mandatory initial commit'
    git add stash.file
    git stash --quiet

    _pure_prompt_git_stash
) = ' ≡'

@test "_pure_prompt_git_stash: symbol is colorized" (
    touch init.file stash.file
    git add init.file
    git commit --quiet --message 'mandatory initial commit'
    git add stash.file
    git stash --quiet

    source (dirname (status filename))/../functions/_pure_set_color.fish # enable colors
    set --universal pure_symbol_git_stash '≡'
    set --universal pure_color_git_stash cyan

    _pure_prompt_git_stash
) = (set_color cyan)' ≡'

