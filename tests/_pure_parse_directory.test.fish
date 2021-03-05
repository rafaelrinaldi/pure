source (dirname (status filename))/fixtures/constants.fish
source (dirname (status filename))/../functions/_pure_parse_directory.fish
@echo (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end; setup


@test "_pure_parse_directory: returns current directory" (
    mkdir -p /tmp/current/directory/
    cd /tmp/current/directory/

    _pure_parse_directory
) = $PWD

@test '_pure_parse_directory: replaces $HOME by ~' (
    pushd $HOME

    _pure_parse_directory
    popd
) = '~'

@test '_pure_parse_directory: shortens directory in prompt' (
    string length (_pure_parse_directory 1)
) -lt (string length $PWD)
