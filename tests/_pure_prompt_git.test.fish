source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_prompt_git.fish
source (dirname (status filename))/../functions/_pure_prompt_git_branch.fish
source (dirname (status filename))/../functions/_pure_parse_git_branch.fish
source (dirname (status filename))/../functions/_pure_string_width.fish
source (dirname (status filename))/../functions/_pure_prompt_git_stash.fish
@echo (_print_filename (status filename))


function setup
    mkdir -p /tmp/test_pure_prompt_git  # prevent conflict between parallel test files
    and cd /tmp/test_pure_prompt_git

    _purge_configs
    _disable_colors
end; setup

function teardown
    rm -rf /tmp/test_pure_prompt_git
end


@test "_pure_prompt_git: ignores directory that are not git repository" (
    function _pure_prompt_git_dirty; echo $EMPTY; end
    function _pure_prompt_git_pending_commits; echo $EMPTY; end

    _pure_prompt_git
) $status -eq $SUCCESS

@test "_pure_prompt_git: activates on git repository" (
    git init --quiet
    function _pure_prompt_git_dirty; echo $EMPTY; end
    function _pure_prompt_git_pending_commits; echo $EMPTY; end

    set --universal pure_enable_git true

    _pure_prompt_git
) = 'master'

@test "_pure_prompt_git: activates on dirty repository" (
    git init --quiet
    function _pure_prompt_git_dirty; echo '*'; end
    function _pure_prompt_git_pending_commits; echo $EMPTY; end

    set --universal pure_enable_git true

    _pure_prompt_git
) = 'master*'

@test "_pure_prompt_git: activates on repository with upstream changes" (
    git init --quiet
    function _pure_prompt_git_dirty; echo $EMPTY; end
    function _pure_prompt_git_pending_commits; echo 'v'; end

    set --universal pure_enable_git true

    _pure_prompt_git
) = 'master v'

@test "_pure_prompt_git: returns an $EMPTY string when pure_enable_git is false" (
    git init --quiet
    function _pure_prompt_git_dirty; echo $EMPTY; end
    function _pure_prompt_git_pending_commits; echo $EMPTY; end

    set --universal pure_enable_git false

    _pure_prompt_git
) $status -eq $SUCCESS


teardown
