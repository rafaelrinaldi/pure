source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_parse_git_branch.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
    mkdir -p /tmp/test_pure_parse_git_branch # prevent conflict between parallel test files
    cd /tmp/test_pure_parse_git_branch

    git init --quiet
    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"
end; setup

function teardown
    rm -rf /tmp/test_pure_parse_git_branch
end


@test "_pure_parse_git_branch: returns current branch" (
    cd /tmp/test_pure_parse_git_branch

    _pure_parse_git_branch
) = 'master'


@test "_pure_parse_git_branch: returns number of commits behind current branch" (
    touch file.txt
    git add file.txt
    git commit --quiet --message="init"

    touch another.txt
    git add another.txt
    git commit --quiet --message="another"

    git checkout --quiet "HEAD~1"

    _pure_parse_git_branch
) = 'master~1'


teardown
