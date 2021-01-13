source $current_dirname/fixtures/constants.fish
@mesg (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end


@test "init: _pure_fresh_session"  (
    set --erase _pure_fresh_session
    source $current_dirname/../conf.d/_pure_init.fish
    echo $_pure_fresh_session
) = true

@test "init: VIRTUAL_ENV_DISABLE_PROMPT"  (
    set --erase VIRTUAL_ENV_DISABLE_PROMPT
    source $current_dirname/../conf.d/_pure_init.fish
    echo $VIRTUAL_ENV_DISABLE_PROMPT
) = 1
