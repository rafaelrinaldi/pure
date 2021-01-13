source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/fish_title.fish
@echo (_print_filename (status filename))


function setup
    mkdir -p /tmp/current/directory/
    cd /tmp/current/directory/

    function _pure_parse_directory; echo /tmp/current/directory; end
end; setup

function teardown
    functions --erase _pure_parse_directory
end


@test "fish_title: contains current directory and previous command" (
    set --universal pure_symbol_title_bar_separator '-'
    fish_title 'last-command'
) = "directory: last-command - fish"

@test "fish_title: contains current directory with an *empty* previous command" (
    fish_title ''
) = "/tmp/current/directory - fish"

@test "fish_title: contains current path without a previous command" (
    set --universal pure_symbol_title_bar_separator '-'
    fish_title
) = "/tmp/current/directory - fish"


teardown
