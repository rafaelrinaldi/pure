source $current_dirname/fixtures/constants.fish
@mesg (_print_filename (status filename))


function setup
    _purge_configs
    _disable_colors
end


@test "init: source uninstall handler"  (
    functions --erase _pure_uninstall
    source $current_dirname/../conf.d/_pure_init.fish
    functions --query _pure_uninstall
) $status -eq $SUCCESS
