source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_prompt_git_dirty.fish
@echo (_print_filename (status filename))


function setup
    mkdir -p /tmp/pure_pure_prompt_git_dirty # prevent conflict between parallel test files
    and cd /tmp/pure_pure_prompt_git_dirty

    git init --quiet
    git config --local user.email "you@example.com"
    git config --local user.name "Your Name"

    _purge_configs
    _disable_colors
end; setup

function teardown
    rm -rf /tmp/pure_pure_prompt_git_dirty
end


@test "_pure_prompt_git_dirty: untracked files make git repo as dirty" (
    touch file.txt
    set --universal pure_symbol_git_dirty '*'

    _pure_prompt_git_dirty
) = '*'

@test "_pure_prompt_git_dirty: staged files mark git repo as dirty" (
    touch file.txt
    git add file.txt
    set --universal pure_symbol_git_dirty '*'

    _pure_prompt_git_dirty
) = '*'

@test "_pure_prompt_git_dirty: symbol is colorized" (
    touch file.txt

    source (dirname (status filename))/../functions/_pure_set_color.fish # enable colors
    set --universal pure_symbol_git_dirty '*'
    set --universal pure_color_git_dirty brblack

    _pure_prompt_git_dirty
) = (set_color brblack)'*'


teardown
