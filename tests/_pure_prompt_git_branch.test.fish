source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_prompt_git_branch.fish
source $current_dirname/../functions/_pure_parse_git_branch.fish
@mesg (_print_filename (status filename))


function setup
    mkdir -p /tmp/test_pure_prompt_git_branch  # prevent conflict between parallel test files
    and cd /tmp/test_pure_prompt_git_branch

    git init --quiet
    git config --local user.email "you@example.com"
    git config --local user.name "Your Name"

    _purge_configs
    _disable_colors
end

function teardown
    rm -rf /tmp/test_pure_prompt_git_branch
end


@test "_pure_prompt_git_branch: show branch name" (
    _pure_prompt_git_branch
) = 'master'

@test "_pure_prompt_git_branch: colorize branch name" (
    source $current_dirname/../functions/_pure_set_color.fish # enable colors
    set --universal pure_color_git_branch grey
    _pure_prompt_git_branch
) = (set_color grey)'master'
