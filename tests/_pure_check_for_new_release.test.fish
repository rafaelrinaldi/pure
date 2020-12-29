source $current_dirname/fixtures/constants.fish
source $current_dirname/../functions/_pure_check_for_new_release.fish
@mesg (print_filename $current_filename)


function _pure_set_color; echo $EMPTY; end # drop coloring during test

@test "_pure_check_for_new_release: is disabled" (
    set --global pure_check_for_new_release false

    _pure_check_for_new_release
) $status -eq $SUCCESS


@test "_pure_check_for_new_release: nothing when same as latest" (
    set --global pure_check_for_new_release true
    set --global pure_version 0.0.1
    function curl; echo '"tag_name": "v0.0.1",'; end # mock

    _pure_check_for_new_release
) = '🛈 Checking for new release…'

@test "_pure_check_for_new_release: show fisher command to install when enable" (
    set --global pure_check_for_new_release true
    set --global pure_version 0.0.1
    function curl; echo '"tag_name": "v9.9.9",'; end # mock

    set output (_pure_check_for_new_release 2>&1)
    echo $output[2] $output[4]
) = '🔔 New version available! fisher install rafaelrinaldi/pure@v9.9.9'

@test "_pure_check_for_new_release: extract release version from JSON" (
    function curl; echo '"tag_name": "v9.9.9",'; end # mock

    pure_get_latest_release_version "rafaelrinaldi/pure"
) = 'v9.9.9'
